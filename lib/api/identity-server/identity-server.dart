import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_components/view-model/user-claims.dart';
import 'i-identity-server.dart';

class IdentityServer implements IIdentityServer {
  String keyAccessToken;
  String keyRefreshToken;
  String keyTokenExpirationDate;
  String keyIdUser;
  String keyUserName;
  String keyIdColaborador;

  SharedPreferences _sharedPreferences;

  UserClaims _user;

  AuthorizationServiceConfiguration _serviceConfiguration =
      AuthorizationServiceConfiguration(
          'https://identity-server-dev.zellar.com.br/connect/authorize',
          'https://identity-server-dev.zellar.com.br/connect/token');

  FlutterAppAuth _appAuth = FlutterAppAuth();

  String _clientId = 'ZPonto';
  String _redirectUrl = 'net.openid.appzponto:/oauth2redirect';
  String _issuer = 'https://identity-server-dev.zellar.com.br';

  String _discoveryUrl =
      'https://identity-server-dev.zellar.com.br/.well-known/openid-configuration';
  List<String> _scopes = [
    'openid',
    'profile',
    'email',
    'offline_access',
    'moltres.acesso.api.full'
  ];

  IdentityServer(
      {this.keyIdColaborador,
      this.keyRefreshToken,
      this.keyAccessToken,
      this.keyTokenExpirationDate,
      this.keyIdUser,
      this.keyUserName}) {
    SharedPreferences.getInstance()
        .then((preferences) => _sharedPreferences = preferences);
  }

  @override
  Future login() async {
    var authorizeAndExchangeCode = await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(_clientId, _redirectUrl,
          serviceConfiguration: _serviceConfiguration, scopes: _scopes),
    );

    if (authorizeAndExchangeCode != null) {
      await _sharedPreferences.setString(
          keyAccessToken, authorizeAndExchangeCode.accessToken);
      await _sharedPreferences.setString(
          keyRefreshToken, authorizeAndExchangeCode.refreshToken);
      await _sharedPreferences.setString(
          keyTokenExpirationDate,
          authorizeAndExchangeCode.accessTokenExpirationDateTime
              .toIso8601String());

      setUserInfo();
    }
  }

  @override
  Future getRefreshToken() async {
    var tokenExpirationDate =
        _sharedPreferences.getString(this.keyTokenExpirationDate);

    if (tokenExpirationDate != null) {
      var expirationDate = DateTime.parse(tokenExpirationDate);

      var deltaTempo =
          new DateTime.now().difference(expirationDate).inMilliseconds;

      if (deltaTempo > 0) {
        var refreshToken = _sharedPreferences.getString(this.keyRefreshToken);

        if (refreshToken != null) {
          // requisitando um novo refresh token
          var result = await _appAuth.token(new TokenRequest(
              '$_clientId', '$_redirectUrl',
              discoveryUrl: '$_discoveryUrl',
              refreshToken: '$refreshToken',
              scopes: _scopes));

          String newAcesstoken = result.accessToken;
          String newIdtoken = result.idToken;
          String newRefreshToken = result.refreshToken;
          String expirationToken =
              result.accessTokenExpirationDateTime.toIso8601String();

          // salvando dados obtidos pela requisição de um novo acess token
          await _sharedPreferences.setString(keyAccessToken, newAcesstoken);
          await _sharedPreferences.setString(refreshToken, newRefreshToken);
          await _sharedPreferences.setString(
              tokenExpirationDate, expirationToken);
        }
      }
    }
  }

  Future<UserClaims> _findUserInfo(String token) async {
    try {
      Dio dio = new Dio();
      var response = await dio.get(
        "https://identity-server-dev.zellar.com.br/connect/userinfo",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      return UserClaims.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

  @override
  UserClaims getUserClaims() {
    return _user;
  }

  @override
  Future setIdColaborador() async {
    await _sharedPreferences.setString(keyIdColaborador, _user.idColaborador);
  }

  @override
  Future setUserInfo() async {
    var token = _sharedPreferences.getString(keyAccessToken);

    _user = await _findUserInfo(token);

    if (_user != null) {
      await _sharedPreferences.setString(keyIdUser, _user.idUser);
      await _sharedPreferences.setString(keyUserName, _user.cpf);
    }
  }
}

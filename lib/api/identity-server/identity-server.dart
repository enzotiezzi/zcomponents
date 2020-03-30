import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_components/api/teste-conexao/i-teste-conexao-service.dart';
import 'package:z_components/api/teste-conexao/teste-conexao-service.dart';
import 'package:z_components/api/token-parser.dart';
import 'package:z_components/components/z-identity-server/login/z-identity-server.dart';
import 'package:z_components/components/z-identity-server/token-info.dart';
import 'package:z_components/settings/api-settings.dart';

import 'i-identity-server.dart';

class IdentityServer implements IIdentityServer {
  String clientId;
  String redirectUrl;
  List<String> scopes;

  SharedPreferences _sharedPreferences;

  ITesteConexaoService _testeConexaoService = new TesteConexaoService();

  UserInfo _user;

  ZIdentityServer _zIdentityServer;

  IdentityServer(
      {@required this.clientId,
      @required this.redirectUrl,
      @required this.scopes}) {
    SharedPreferences.getInstance()
        .then((preferences) => _sharedPreferences = preferences);
    _zIdentityServer = new ZIdentityServer(
        clientId: clientId, redirectURI: redirectUrl, scopes: scopes);
  }

  @override
  Future login() async {
    var authorizeAndExchangeCode = await _zIdentityServer.authorize();

    if (authorizeAndExchangeCode != null) {
      await _sharedPreferences.setString(
          ApiSettings.API_TOKEN, authorizeAndExchangeCode.accessToken);
      await _sharedPreferences.setString(
          ApiSettings.REFRESH_TOKEN, authorizeAndExchangeCode.refreshToken);
      await _sharedPreferences.setString(
        ApiSettings.TOKEN_EXPIRATION_DATE,
        DateTime.now()
            .add(Duration(seconds: authorizeAndExchangeCode.expiresIn))
            .toIso8601String(),
      );

      await setUserInfo();
    }
  }

  @override
  Future refreshToken() async {
    try {
      var online = await _testeConexaoService.testarConexao();

      if (online) {
        var tokenExpirationDate =
            _sharedPreferences.getString(ApiSettings.TOKEN_EXPIRATION_DATE);

        if (tokenExpirationDate != null) {
          var expirationDate = DateTime.parse(tokenExpirationDate);

          var deltaTempo =
              new DateTime.now().difference(expirationDate).inMilliseconds;

          if (deltaTempo > 0) {
            var refreshToken =
                _sharedPreferences.getString(ApiSettings.REFRESH_TOKEN);

            if (refreshToken != null) {
              await _refreshToken();
            }
          }
        }
      }
    } on Exception catch (e) {
      return;
    }
  }

  Future _refreshToken() async {
    try {
      var refreshToken =
          _sharedPreferences.getString(ApiSettings.REFRESH_TOKEN);

      // requisitando um novo refresh token
      var result = await _zIdentityServer.refreshToken(refreshToken);

      if (result != null) {
        String newAcesstoken = result.accessToken;
        String newIdtoken = result.idToken;
        String newRefreshToken = result.refreshToken;
        String expirationToken = DateTime.now()
            .add(Duration(seconds: result.expiresIn))
            .toIso8601String();

        // salvando dados obtidos pela requisição de um novo acess token
        await _sharedPreferences.setString(
            ApiSettings.API_TOKEN, newAcesstoken);
        await _sharedPreferences.setString(
            ApiSettings.REFRESH_TOKEN, newRefreshToken);
        await _sharedPreferences.setString(
            ApiSettings.TOKEN_EXPIRATION_DATE, expirationToken);
      }
    } catch (e) {
      await login();
    }
  }

  Future<UserInfo> _findUserInfo(String token) async {
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

      return UserInfo.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

  @override
  UserInfo getUserInfo() {
    return _user;
  }

  @override
  Future setIdColaborador() async {}

  @override
  Future setUserInfo() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var token = _sharedPreferences.getString(ApiSettings.API_TOKEN);

    _user = await _findUserInfo(token);

    if (_user != null) {
      await _sharedPreferences.setString(ApiSettings.API_ID_USER, _user.idUser);
      await _sharedPreferences.setString(ApiSettings.API_USERNAME, _user.cpf);
    }
  }

  @override
  Future logout(Function function, {String token}) async {
    await _zIdentityServer.logOut(function, token: token);
  }

  @override
  Future<String> getCurrentIdAccount() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    var accessToken = _sharedPreferences.getString(ApiSettings.API_TOKEN);

    var tokenInfo = UserInfo.fromJson(TokenParser.parseJwt(accessToken));

    return tokenInfo.idConta;
  }

  @override
  Future<Null> forceRefreshToken() async {
    await _refreshToken();
  }
}

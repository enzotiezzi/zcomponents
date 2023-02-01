import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart' as x;
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:z_components/api/identity-server/identity-server.dart';
import 'package:z_components/components/z-identity-server/js-channels.dart';
import 'package:z_components/components/z-identity-server/token-info.dart';
import 'package:z_components/components/z-identity-server/z-token-viewmodel.dart';

class ZIdentityServer {
  String? clientId;
  String? redirectURI;
  List<String>? scopes;
  String? authorizeURL;
  String? tokenURL;

  FlutterWebviewPlugin _flutterWebviewPlugin = new FlutterWebviewPlugin();
  late SharedPreferences _sharedPreferences;

  late String _codeVerifier;

  ZIdentityServer(
      {@required this.clientId,
      @required this.redirectURI,
      @required this.scopes,
      @required this.authorizeURL,
      @required this.tokenURL});

  Future<ZTokenViewModel?> authorize() async {
    try {
      _flutterWebviewPlugin = new FlutterWebviewPlugin();

      _flutterWebviewPlugin.onUrlChanged.listen((url) {
        if (url.contains("code=") && url.contains(redirectURI!))
          _flutterWebviewPlugin.reload();
      });

      await _flutterWebviewPlugin.launch(_generateURI().toString(),
          javascriptChannels: <JavascriptChannel>[
            JsChannels.getChannelFecharWebView((javaScriptMessage) {
              _flutterWebviewPlugin.close().then((_) {
                _flutterWebviewPlugin.dispose();
              });
            }),
          ].toSet());

      var url = await _flutterWebviewPlugin.onUrlChanged.firstWhere(
          (url) => url.contains("code=") && url.contains(redirectURI!));

      await _flutterWebviewPlugin.close();
      _flutterWebviewPlugin.dispose();

      var code = Uri.parse(url).queryParameters['code'];

      var tokenViewModel = await _getToken(code!);

      return tokenViewModel;
    } catch (e) {
      return null;
    }
  }

  Future<ZTokenViewModel?> refreshToken(String refreshToken) async {
    try {
      final response = await http.post(
         Uri.parse( 'https://${IdentityServer.address}/connect/token'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          },
          body: {
            'client_id': clientId,
            'redirect_uri': redirectURI,
            'grant_type': 'refresh_token',
            'refresh_token': refreshToken,
            'scope': scopes?.join(" ")
          });

      var tokenViewModel = ZTokenViewModel.fromJson(json.decode(response.body));

      return tokenViewModel;
    } catch (e) {
      return null;
    }
  }

  Future<void> logOut(Function onLogOut, {String? token}) async {
    _flutterWebviewPlugin = new FlutterWebviewPlugin();

    if (Platform.isIOS) {
      _flutterWebviewPlugin.onUrlChanged.listen((url) {
        if (url.toLowerCase().contains("account/login")) {
          _flutterWebviewPlugin.close().then((_) {
            _flutterWebviewPlugin.dispose();

            if (onLogOut != null) onLogOut();
          });
        }
      });
    }

    await _flutterWebviewPlugin.launch(
        "https://${IdentityServer.address}/account/Logout?inApp=true",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        javascriptChannels: <JavascriptChannel>[
          JsChannels.getChannelOkWebView((javaScriptMessage) {
            _flutterWebviewPlugin.close().then((_) {
              _flutterWebviewPlugin.dispose();

              if (onLogOut != null) onLogOut();
            });
          })
        ].toSet());
  }

  String _generateURI() {
    var state = _generateState();
    _codeVerifier = _generateCodeVerifier();
    var codeChallengeBase64 = _generateCodeChallenge(_codeVerifier);

    final url =
        Uri.https(IdentityServer.address, '/connect/authorize', {
      'tipoSenha': 'pin',
      'inApp': 'true',
      'response_type': 'code',
      'client_id': clientId,
      'redirect_uri': redirectURI,
      'scope': scopes?.join(" "),
      'state': state,
      'code_challenge': codeChallengeBase64,
      'code_challenge_method': 'S256'
    }).toString();

    return url;
  }

  String _generateCodeVerifier() {
    var random = Random.secure();
    final ret = Uint8List(32);

    for (var i = 0; i < 32; i++) {
      ret[i] = random.nextInt(256);
    }

    return _toBase64URLEncode(ret);
  }

  String _generateCodeChallenge(String codeVerifier) {
    return _toBase64URLEncode(
        x.sha256.convert(new Utf8Encoder().convert(codeVerifier)).bytes);
  }

  String _generateState() {
    return base64UrlEncode(new Utf8Encoder().convert(new Uuid().v1()));
  }

  String _toBase64URLEncode(List<int> buffer) {
    return base64UrlEncode(buffer)
        .replaceAll("+", "-")
        .replaceAll("/", "_")
        .replaceAll("\\", "_")
        .replaceAll("=", "");
  }

  Future<ZTokenViewModel?> _getToken(String code) async {
    try {
      final response = await http.post(
          Uri.parse('https://${IdentityServer.address}/connect/token'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          },
          body: {
            'client_id': clientId,
            'redirect_uri': redirectURI,
            'grant_type': 'authorization_code',
            'code': code,
            'code_verifier': _codeVerifier
          });

      var tokenViewModel = ZTokenViewModel.fromJson(json.decode(response.body));

      return tokenViewModel;
    } catch (e) {
      return null;
    }
  }
}

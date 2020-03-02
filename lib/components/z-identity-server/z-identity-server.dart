import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart' as x;
import 'package:http/http.dart' as http;
import 'package:randombytes/randombytes.dart';
import 'package:z_components/components/z-identity-server/z-token-viewmodel.dart';

class IdentityServer {
  String clientId;
  String redirectURI;
  List<String> scopes;

  final _flutterWebviewPlugin = new FlutterWebviewPlugin();

  String _codeVerifier;

  IdentityServer({this.clientId, this.redirectURI, this.scopes});

  Future<ZTokenViewModel> authorize() async {
    try {
      _flutterWebviewPlugin.launch(_generateURI());

      var url = await _flutterWebviewPlugin.onUrlChanged.firstWhere(
          (url) => url.contains("code=") && url.contains(redirectURI));

      _flutterWebviewPlugin.close();
      _flutterWebviewPlugin.dispose();

      var code = Uri.parse(url).queryParameters['code'];

      final response = await http.post(
          'https://identity-server-dev.zellar.com.br/connect/token',
          headers: {
            "CONTENT-TYPE": "application/x-www-form-urlencoded"
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

  Future<ZTokenViewModel> refreshToken(String refreshToken) async {
    try {
      final response = await http.post(
          'https://identity-server-dev.zellar.com.br/connect/token',
          headers: {
            "CONTENT-TYPE": "application/x-www-form-urlencoded"
          },
          body: {
            'client_id': clientId,
            'redirect_uri': redirectURI,
            'grant_type': 'refresh_token',
            'refresh_token': refreshToken,
            'scope': scopes.join(" ")
          });

      var tokenViewModel = ZTokenViewModel.fromJson(json.decode(response.body));

      return tokenViewModel;
    } catch (e) {
      return null;
    }
  }

  String _generateURI() {
    var state = _generateState();
    _codeVerifier = _generateCodeVerifier();
    var codeChallengeBase64 = _generateCodeChallenge(_codeVerifier);

    final url =
        Uri.https('identity-server-dev.zellar.com.br', '/connect/authorize', {
      'response_type': 'code',
      'client_id': clientId,
      'redirect_uri': redirectURI,
      'scope': scopes.join(" "),
      'state': state,
      'code_challenge': codeChallengeBase64,
      'code_challenge_method': 'S256'
    }).toString();

    return url;
  }

  String _generateCodeVerifier() {
    var random = randomBytes(32, secure: true);

    return _toBase64URLEncode(random);
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
}
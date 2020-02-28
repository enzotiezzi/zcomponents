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
    ZTokenViewModel tokenViewModel = null;

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

    if (response.statusCode == 200) {
      tokenViewModel = ZTokenViewModel.fromJson(json.decode(response.body));
    }

    return tokenViewModel;
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

class ZIdentityServer extends StatefulWidget {
  @override
  _ZIdentityServerState createState() => new _ZIdentityServerState();
}

class _ZIdentityServerState extends State<ZIdentityServer> {
  String _clientId = 'ZPonto';
  String _redirectUrl = 'net.openid.appzponto:/oauth2redirect';

  List<String> _scopes = [
    'openid',
    'profile',
    'email',
    'offline_access',
    'moltres.acesso.api.full'
  ];

  final _flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  String _codeVerifier = "";

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = _flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged = _flutterWebviewPlugin.onStateChanged
        .listen((WebViewStateChanged state) {
      print("onStateChanged: ${state.type} ${state.url}");
    });

    // Add a listener to on url changed
    _onUrlChanged =
        _flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (url.contains("code=")) {
        var code = Uri.parse(url).queryParameters['code'];

        final response = await http.post(
            'https://identity-server-dev.zellar.com.br/connect/token',
            headers: {
              "CONTENT-TYPE": "application/x-www-form-urlencoded"
            },
            body: {
              'client_id': _clientId,
              'redirect_uri': '$_redirectUrl',
              'grant_type': 'authorization_code',
              'code': code,
              'code_verifier': _codeVerifier
            });

        final accessToken = jsonDecode(response.body)['access_token'] as String;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = _generateState();
    _codeVerifier = _generateCodeVerifier();
    var codeChallengeBase64 = _generateCodeChallenge(_codeVerifier);

    final url =
        Uri.https('identity-server-dev.zellar.com.br', '/connect/authorize', {
      'response_type': 'code',
      'client_id': _clientId,
      'redirect_uri': '$_redirectUrl',
      'scope': 'openid',
      'state': state,
      'code_challenge': codeChallengeBase64,
      'code_challenge_method': 'S256'
    });

    print("${url.toString()}");

    return new WebviewScaffold(url: url.toString());
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

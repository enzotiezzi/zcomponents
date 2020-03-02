import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ZRegisterUser {
  final _flutterWebviewPlugin = new FlutterWebviewPlugin();

  final String _register_url =
      "https://identity-server-dev.zellar.com.br/account/register?tipoSenha=pin&inApp=true";

  final String _DONE = "DONE";

  Future<void> signUp(Function onSignUpComplete()) async {
    await _flutterWebviewPlugin.launch(_register_url,
        javascriptChannels: <JavascriptChannel>[
          new JavascriptChannel(
              name: "register",
              onMessageReceived: (javaScriptMessage) async {
                await _flutterWebviewPlugin.close();
                _flutterWebviewPlugin.dispose();

                if (onSignUpComplete != null) onSignUpComplete();
              })
        ].toSet());
  }
}

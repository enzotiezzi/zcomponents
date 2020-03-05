import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:z_components/components/z-identity-server/js-channels.dart';

class ZRegisterUser {
  final _flutterWebviewPlugin = new FlutterWebviewPlugin();

  Future<void> signUp(Function onSignUpComplete,
      Map<String, String> additionalParameters) async {
    additionalParameters.addAll({"inApp": "true", "tipoSenha": "pin"});

    var uri = new Uri.https("identity-server-dev.zellar.com.br",
        "/account/register", additionalParameters);

    await _flutterWebviewPlugin.launch(uri.toString(),
        javascriptChannels: <JavascriptChannel>[
          JsChannels.getChanngelFecharWebView((javaScriptMessage) async {
            await _flutterWebviewPlugin.close();
            _flutterWebviewPlugin.dispose();

            if (onSignUpComplete != null) onSignUpComplete();
          }),
        ].toSet());
  }
}

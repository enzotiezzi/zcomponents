import 'dart:io';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_components/api/identity-server/identity-server.dart';
import 'package:z_components/components/z-identity-server/js-channels.dart';

class VinculoConta {
  String token;

  FlutterWebviewPlugin _flutterWebviewPlugin;

  final String _vinculo_url =
      "https://${IdentityServer.address}/account/contas/localizar";

  VinculoConta({@required this.token});

  Future<Null> vincularConta(Function onBindAccount) async {
    _flutterWebviewPlugin = new FlutterWebviewPlugin();

    _flutterWebviewPlugin.launch(_vinculo_url,
        javascriptChannels: <JavascriptChannel>[
          JsChannels.getChannelFecharWebView((javaScriptMessage) async {
            await _flutterWebviewPlugin.close();
            _flutterWebviewPlugin.dispose();

            if (onBindAccount != null) onBindAccount();
          }),
        ].toSet());
  }
}

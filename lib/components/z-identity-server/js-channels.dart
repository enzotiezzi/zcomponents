import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class JsChannels {
  static JavascriptChannel getChanngelFecharWebView(
      Function(JavascriptMessage) onMessageReceived) {
    return new JavascriptChannel(
        name: "fecharWebView", onMessageReceived: onMessageReceived);
  }

  static JavascriptChannel getChanngelOkWebView(
      Function(JavascriptMessage) onMessageReceived) {
    return new JavascriptChannel(
        name: "okWebView", onMessageReceived: onMessageReceived);
  }
}

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class JsChannels {
  static JavascriptChannel getChannelFecharWebView(
      Function(JavascriptMessage) onMessageReceived) {
    return new JavascriptChannel(
        name: "fecharWebView", onMessageReceived: onMessageReceived);
  }

  static JavascriptChannel getChannelOkWebView(
      Function(JavascriptMessage) onMessageReceived) {
    return new JavascriptChannel(
        name: "okWebView", onMessageReceived: onMessageReceived);
  }
}

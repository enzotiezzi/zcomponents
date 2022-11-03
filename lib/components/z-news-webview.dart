import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ZNewsWebView extends StatefulWidget {
  String url;
  String titulo;

  ZNewsWebView({this.url, this.titulo});

  @override
  ZNewsWebViewState createState() => ZNewsWebViewState();
}

class ZNewsWebViewState extends State<ZNewsWebView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Text(widget.titulo ?? ""),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:z_components/components/utils/icone-voltar.dart';

class ZNewsWebView extends StatefulWidget {
  String? url;
  String? titulo;

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
      displayZoomControls: true,
      withZoom: true,
      url: _retornarURL(),
      appBar: new AppBar(
        centerTitle: true,
        leading: IconeVoltar(
          context: context,
        ),
        title: new Text(widget.titulo ?? ""),
      ),
    );
  }

  String _retornarURL(){
    if(widget.url != null){
      return widget.url!;
    }else{
      return "";
    }
  }
}

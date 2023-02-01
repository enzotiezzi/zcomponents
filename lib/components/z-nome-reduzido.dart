import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZNomeReduzido extends StatefulWidget {
  final String? text;
  final TextStyle? textStyle;

  ZNomeReduzido({this.text, this.textStyle});

  @override
  _ZNomeReduzidoState createState() => _ZNomeReduzidoState();
}

class _ZNomeReduzidoState extends State<ZNomeReduzido> {
  String? ultimoReduzido = "";
  String? primeiroReduzido= "";
  String? texto= "";

  @override
  void initState() {
    nomeReduzido(widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (texto != null) {
      return (texto!.length > 25)
          ? new Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width / 9,
                  child: new Text(
                    primeiroReduzido ?? "",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                new Container(
                  child: new Text(
                    ultimoReduzido ?? "",
                    style: widget.textStyle,
                  ),
                )
              ],
            )
          : new Container(
              child: new Text(texto!, style: widget.textStyle),
            );
    } else {
      return new Container(
        child: new Text("", style: widget.textStyle),
      );
    }
  }

  void nomeReduzido(String? text) {
    if (text != null) {
      text = text.trim();
      if (text.contains(" ")) {
        primeiroReduzido = text.substring(0, text.indexOf(" ")).trim();
        ultimoReduzido =
            text.substring(text.lastIndexOf(" "), text.length).trim();
        String nomeTotal = primeiroReduzido! + " " + ultimoReduzido!;

        if (mounted)
          setState(() {
            texto = nomeTotal;
          });
      }
    }
  }
}

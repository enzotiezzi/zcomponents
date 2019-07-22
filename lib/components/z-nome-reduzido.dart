import 'package:flutter/material.dart';

class ZNomeReduzido extends StatefulWidget {
  String text;

  ZNomeReduzido({this.text});

  @override
  _ZNomeReduzidoState createState() => _ZNomeReduzidoState();
}

class _ZNomeReduzidoState extends State<ZNomeReduzido> {
  String ultimoReduzido;
  String primeiroReduzido;
  String texto;

  @override
  void initState() {
    nomeReduzido(widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (texto.length > 25)
        ? new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width / 9,
                child: new Text(
                  primeiroReduzido,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              new Container(
                child: new Text(ultimoReduzido),
              )
            ],
          )
        : new Container(
            child: new Text(texto),
          );
  }

  void nomeReduzido(String text) {
    primeiroReduzido = text.substring(0, text.indexOf(" ")).trim();
    ultimoReduzido = text.substring(text.lastIndexOf(" "), text.length).trim();
    String nomeTotal = primeiroReduzido + " " + ultimoReduzido;
    texto = nomeTotal;
  }
}

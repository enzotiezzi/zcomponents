import 'package:flutter/material.dart';

class PermissaoNegada extends StatefulWidget {
  String textoPermissao;
  String caminhoImagem;
  Function onPressed;

  PermissaoNegada(
      {Key key, this.caminhoImagem, this.textoPermissao, this.onPressed})
      : super(key: key);

  @override
  _PermissaoNegadaState createState() => _PermissaoNegadaState();
}

class _PermissaoNegadaState extends State<PermissaoNegada> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "PERMISSÂO",
          style: const TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Container(
            margin: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: Image.asset(widget.caminhoImagem),
          ),
          new Container(
            margin: EdgeInsets.only(right: 16.0, left: 16.0),
            child: new Text(
              widget.textoPermissao,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          _exibirBotao()
        ],
      ),
    );
  }

  Widget _exibirBotao() {
    return new Material(
      elevation: 4.0,
      child: new Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height / 8,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new ElevatedButton(
              style: new ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(new Color(0xff2bbab4)),
                shadowColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                padding: MaterialStateProperty.all(const EdgeInsets.only(
                    top: 8, bottom: 8, left: 16, right: 16)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                )),
              ),
              onPressed: widget.onPressed,
              child: new Text(
                "Ir para configurações",
                style: new TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}

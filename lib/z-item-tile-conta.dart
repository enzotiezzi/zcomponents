import 'package:flutter/material.dart';

class ZItemTileConta extends StatefulWidget {
  final Widget imagemPerfil;
  String nomeConta;
  String appsVinculados;
  String dataVinculo;
  bool ativo;
  bool visibilidade;
  int tamanhoLista;

  ZItemTileConta(
      {this.imagemPerfil,
      this.dataVinculo,
      this.appsVinculados,
      this.ativo,
      this.nomeConta,
      this.visibilidade,
      this.tamanhoLista});

  @override
  _ZItemTileContaState createState() => _ZItemTileContaState();
}

class _ZItemTileContaState extends State<ZItemTileConta> {
  @override
  Widget build(BuildContext context) {
    return new IntrinsicHeight(
      child: new Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: new Material(
            //elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)),
            child: new Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  new Expanded(
                    flex: 20,
                    child: new Container(
                      margin: const EdgeInsets.only(
                          left: 4, right: 4, bottom: 4, top: 4),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFF808080),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                      ),
                      child: retornarImagem(),
                    ),
                  ),
                  new Expanded(
                    flex: 95,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new Container(
                                margin: EdgeInsets.only(left: 4.0, top: 10.0),
                                child: new Text(widget.nomeConta)),
                            _montarAtivo()
                          ],
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: new Container(
                                  margin: EdgeInsets.only(left: 4.0),
                                  child: new Text(
                                    "Apps:",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.0),
                                  )),
                            ),
                            _montarTamanhoLista(),
                            Expanded(
                              flex: 25,
                              child: new Container(
                                margin: EdgeInsets.only(
                                  left: 4.0,
                                ),
                                child: retotnarAppVinculado(),
                              ),
                            ),
                          ],
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Container(
                              margin: EdgeInsets.only(left: 4.0, bottom: 10.0),
                              child: new Text(
                                "Data de vinculo: ",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12.0),
                              ),
                            ),
                            new Container(
                              margin: EdgeInsets.only(left: 4.0, bottom: 10.0),
                              child: new Text(
                                widget.dataVinculo,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  _retornarArrow()
                ],
              ),
            )),
      ),
    );
  }

  Widget _retornarArrow() {
    if (widget.visibilidade) {
      return Container();
    } else {
      return Expanded(
        flex: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      );
    }
  }

  Widget _montarTamanhoLista() {
    if (widget.tamanhoLista != null && widget.tamanhoLista != 0) {
      return new Container(
          margin: EdgeInsets.only(right: 4.0),
          padding: EdgeInsets.only(top: 4.0, bottom: 4, left: 6, right: 6),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
              borderRadius: BorderRadius.circular(6)),
          child: new Text(widget.tamanhoLista.toString()),
        );
    } else
      return new Container();
  }

  Widget retotnarAppVinculado() {
    if (widget.appsVinculados == null) {
      return new Text('');
    } else {
      return new Text(
        widget.appsVinculados,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Color(0xFF000000),
          fontSize: 12,
        ),
      );
    }
  }

  Widget retornarImagem() {
    if (widget.imagemPerfil == null) {
      return new Icon(
        Icons.insert_photo,
        color: Color(0xFFffffff),
      );
    } else {
      return new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0)),
          color: Colors.transparent,
        ),
        child: widget.imagemPerfil,
      );
    }
  }

  Widget _montarAtivo() {
    if (!widget.ativo) {
      return new Container();
    } else {
      return new Container(
        padding: EdgeInsets.all(4.0),
        margin: EdgeInsets.only(right: 10.0, top: 10.0),
        decoration: BoxDecoration(
            color: Color(0xff2bbab4),
            borderRadius: BorderRadius.circular(12.0)),
        child: new Text(
          "Ativo",
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      );
    }
  }
}

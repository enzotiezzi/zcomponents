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
            color: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: new Container(
              alignment: Alignment.centerLeft,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  new Expanded(
                    flex: 20,
                    child: new Container(
                      margin: const EdgeInsets.only(
                          left: 4, right: 4, bottom: 4, top: 4),
                      height: 80,
                      decoration: new BoxDecoration(
                        color: const Color(0xFF808080),
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          bottomLeft: const Radius.circular(8.0),
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
                            new Expanded(
                              flex:25,
                              child: new Container(
                                  margin: const EdgeInsets.only(left: 4.0, top: 8.0),
                                  child: new Text(widget.nomeConta,
                                    overflow: TextOverflow.ellipsis,
                                  )
                              ),
                            ),
                            _montarAtivo()
                          ],
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Expanded(
                              flex: 5,
                              child: new Container(
                                  margin: const EdgeInsets.only(left: 4.0),
                                  child: new Text(
                                    "Apps:",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.0),
                                  )),
                            ),
                            _montarTamanhoLista(),
                            new Expanded(
                              flex: 25,
                              child: new Container(
                                margin: const EdgeInsets.only(
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
                              margin: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                              child: new Text(
                                "Data de vinculo: ",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12.0),
                              ),
                            ),
                            new Container(
                              margin: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                              child: new Text(
                                widget.dataVinculo,
                                style: const TextStyle(fontSize: 12),
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
      return new Container();
    } else {
      return new Expanded(
        flex: 10,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      );
    }
  }

  Widget _montarTamanhoLista() {
    if (widget.tamanhoLista != null && widget.tamanhoLista != 0) {
      return new Container(
        margin: const EdgeInsets.only(right: 4.0),
        padding: const EdgeInsets.only(top: 4.0, bottom: 4, left: 8, right: 8),
        decoration: new BoxDecoration(
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
        style: const TextStyle(
          color: const Color(0xFF000000),
          fontSize: 12,
        ),
      );
    }
  }

  Widget retornarImagem() {
    if (widget.imagemPerfil == null) {
      return new Icon(
        Icons.insert_photo,
        color: const Color(0xFFffffff),
      );
    } else {
      return new Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(4), bottomLeft: const Radius.circular(4)),
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
        padding: const EdgeInsets.all(4.0),
        margin: const EdgeInsets.only(right: 8.0, top: 8.0),
        decoration: new BoxDecoration(
            color: const Color(0xff2bbab4),
            borderRadius: new BorderRadius.circular(16.0)),
        child: new Text(
          "Ativo",
          style: const TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      );
    }
  }
}

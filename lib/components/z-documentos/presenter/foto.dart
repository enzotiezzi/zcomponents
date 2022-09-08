import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/components/z-documentos/view/foto-view.dart';
import 'package:z_components/config/z-dialog.dart';

class Foto extends StatefulWidget {
  final Uint8List image;
  final String imageOriginal;
  final int hero;
  final int hero2;
  final bool finalizacaoChamado;
  final Uint8List imagem;
  final List<Uint8List> fotos;

  Foto(
      {this.image,
      this.hero,
      this.imageOriginal,
      this.hero2,
      this.finalizacaoChamado: false,
      this.imagem,
      this.fotos});

  static final String ROUTER = "/foto";

  @override
  State<StatefulWidget> createState() => _Foto();
}

class _Foto extends State<Foto> {
  FotoView _view;

  @override
  void initState() {
    super.initState();
    _view = new FotoView(this);
    _view.initView();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            if (widget.finalizacaoChamado == true) {
            } else {
              Navigator.pop(context);
            }
          },
          child: new Container(
            color: Colors.transparent,
            child: Center(
                child: Material(
                    color: Colors.transparent,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Hero(
                            tag: "image${widget.hero}${widget.hero2}",
                            child: new GestureDetector(
                                onTap: () {},
                                child:
                                    //(_view.carregou == false)?
                                    new Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffe6e6e6),
                                      border: new Border.all(
                                          color: Colors.white, width: 2),
                                      borderRadius: BorderRadius.circular(6.0),
                                      image: DecorationImage(
                                          image: (widget.finalizacaoChamado ==
                                                  false)
                                              ? MemoryImage(widget.image)
                                              : MemoryImage(widget.imagem),
                                          fit: BoxFit.cover)),
                                  margin: EdgeInsets.only(bottom: 16),
                                  height: 300,
                                  width: 300,
                                )
                                /*    :new Container(
                    decoration: BoxDecoration(
                        color: Color(0xffe6e6e6),
                        border: new Border.all(color: Colors.white,width: 2),
                        borderRadius: BorderRadius.circular(6.0),
                        image: DecorationImage(
                            image: MemoryImage(_view.fotoOriginal),
                            fit: BoxFit.cover)),
                    margin: EdgeInsets.only(left: 16,bottom: 16),
                    height:300,
                    width: 300,
                  ),*/
                                )),
                        (widget.finalizacaoChamado == true)
                            ? new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new RaisedButton(
                                    onPressed: () {
                                      _view.selecionarItem(widget.fotos);
                                    },
                                    child: new Container(
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Container(
                                            padding: const EdgeInsets.only(
                                                right: 6, left: 6),
                                            child: new Text(
                                              "CANCELAR",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    color: Colors.white,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    splashColor: Colors.grey.withOpacity(0.5),
                                  ),
                                  new RaisedButton(
                                    onPressed: () async {
                                      _buildDialogDeletarimagem(context);
                                    },
                                    child: new Container(
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Container(
                                            padding: const EdgeInsets.only(
                                                right: 6, left: 6),
                                            child: new Text(
                                              "EXCLUIR",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    color: Colors.red,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    splashColor: Colors.grey.withOpacity(0.5),
                                  )
                                ],
                              )
                            : new Container()
                      ],
                    ))),
          ),
        ),
      ),
      onWillPop: willPopCallback,
    );
  }

  Future<bool> willPopCallback() async {
    if (widget.finalizacaoChamado == false) {
      Navigator.pop(context);
    } else {
      _view.selecionarItem(widget.fotos);
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future _buildDialogDeletarimagem(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => new ZAlertDialog(
        zDialog: ZDialog.alert,
        colorLine: const Color(0xFF1e26f7),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Container(
              child: new Text(
                "Atenção",
                style: new TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 8, left: 4, right: 4),
              width: MediaQuery.of(context).size.width * 0.7,
              child: new Text(
                "Deseja mesmo excluir esta imagem?",
                style: new TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Container(
                    margin: const EdgeInsets.only(bottom: 8, top: 8),
                    child: new Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 22,
                      margin: const EdgeInsets.only(top: 8),
                      child: new Text(
                        "CANCELAR",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                new TextButton(
                  onPressed: () {
                    _view.verificarSeDesejaExcluir(true);
                  },
                  child: new Container(
                    margin: const EdgeInsets.only(bottom: 8, top: 8),
                    child: new Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 22,
                      margin: const EdgeInsets.only(top: 8),
                      child: new Text(
                        "CONFIRMAR",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

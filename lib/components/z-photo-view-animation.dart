import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ZFotoAnimationView extends StatefulWidget {

  final Uint8List? image;
  final String? imageOriginal;
  final int? hero;
  final int? hero2;
  final bool? finalizacaoChamado;
  final String? caminho;
  final List<String>? fotos;

  ZFotoAnimationView({
    this.image,this.hero,this.imageOriginal,this.hero2,this.finalizacaoChamado: false,this.caminho,this.fotos});

  @override
  State<StatefulWidget> createState() => _ZFotoAnimationViewState();
}

class _ZFotoAnimationViewState extends State<ZFotoAnimationView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: GestureDetector(
        onTap: (){
          if(widget.finalizacaoChamado !=null && widget.finalizacaoChamado == true)
          {}
          else{
            Navigator.pop(context);
          }
        },
        child: new Container(
          color: Colors.transparent,
          child: Center(
              child: Material(
                  color: Colors.transparent,
                  child:new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Hero(tag: "image${widget.hero}${widget.hero2}", child:
                      new GestureDetector(
                          onTap: (){},
                          child:
                          //(_view.carregou == false)?
                          new Container(
                            decoration: BoxDecoration(
                                color: Color(0xffe6e6e6),
                                border: new Border.all(color: Colors.white,width: 2),
                                borderRadius: BorderRadius.circular(6.0),
                                image: DecorationImage(
                                    image:_retornarImagem(),
                                    fit: BoxFit.cover)),
                            margin: EdgeInsets.only(bottom: 16),
                            height:300,
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
                      (widget.finalizacaoChamado == true)?
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new ElevatedButton(
                            onPressed: () {
                              _selecionarItem(widget.fotos);
                            },
                            child: new Container(
                              child: new Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Container(
                                    padding: const EdgeInsets.only(right: 6, left: 6),
                                    child: new Text(
                                      "CANCELAR",
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            style: new ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                              shadowColor:
                              MaterialStateProperty.all<Color>(Colors.transparent),
                              padding: MaterialStateProperty.all(EdgeInsets.only(
                                  left: 10, right: 10)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                  )),
                            ),
                          ),
                          new ElevatedButton(
                            onPressed: () {
                              widget.fotos?.removeAt(widget.hero!);
                              _selecionarItem(widget.fotos);
                            },
                            child: new Container(
                              child: new Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Container(
                                    padding: const EdgeInsets.only(right: 6, left: 6),
                                    child: new Text(
                                      "EXCLUIR",
                                      style: TextStyle(color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            style: new ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                              shadowColor:
                              MaterialStateProperty.all<Color>(Colors.transparent),
                              padding: MaterialStateProperty.all(EdgeInsets.only(
                                  left: 10, right: 10)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                  )),
                            ),
                          )

                        ],
                      ):new Container()
                    ],
                  )
              )
          ),
        ),
      ),
      onWillPop: willPopCallback,);
  }

  void _selecionarItem(List<String>? item) {
    Navigator.of(context).pop(item);
  }
  Future<bool> willPopCallback() async {
    if (widget.finalizacaoChamado != null && widget.finalizacaoChamado == false) {
      Navigator.pop(context);
    } else {
      _selecionarItem(widget.fotos);
    }
    return false;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  ImageProvider _retornarImagem(){
    if(widget.finalizacaoChamado != null && widget.finalizacaoChamado == false){
      return MemoryImage(widget.image!);
    }else{
      return FileImage(File(widget.caminho!));
    }
  }
}
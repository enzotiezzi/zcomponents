import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:z_components/components/z-hero-transition-class.dart';
import 'package:z_components/components/z-photo-view-animation.dart';

class ZTakePhoto extends StatefulWidget {
  List<String> fotos;
  final bool permissaoGaleria;
  final bool fotoObrigatoria;
  final bool finalizacaoChamado;
  final Color primaryColorApp;
  final Uint8List image;

  ScrollController scrollControllerTela;


  ZTakePhoto({this.fotos,
    this.permissaoGaleria: true,
    this.fotoObrigatoria: false,
    this.primaryColorApp: const Color(0xff2bbab4),
    this.finalizacaoChamado: false,
    this.scrollControllerTela,
  this.image
  });

  @override
  State<StatefulWidget> createState() => _ZTakePhotoState();
}

class _ZTakePhotoState extends State<ZTakePhoto> {
  String foto;
  List<String> fotosAmplia = new List();

  final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ]);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          margin:
          EdgeInsets.only(top: 20, bottom: (widget.fotos.length > 0) ? 0 : 80),
          child: new InkWell(
            onTap: () {
              if (widget.permissaoGaleria == true) {
                showDialogBottomFoto();
              }
              else {
                openCamera();
              }
            },
            child: new Container(
                color: Colors.white,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Container(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 10, bottom: 10),
                            child: new Text(
                              "ADICIONAR FOTO",
                              style: new TextStyle(
                                  color: widget.primaryColorApp,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            )),
                        new Container(
                          margin: EdgeInsets.only(right: (widget
                              .fotoObrigatoria == true && widget.fotos.length ==
                              0) ? 0 : 16),
                          child: new Icon(
                            Icons.camera_enhance,
                            color: widget.primaryColorApp,
                          ),
                        ),
                        _buildObrigatoriedadeFoto()
                      ],
                    )
                  ],
                )),
          ),
        ),
        _buildListaFotos()
      ],
    );
  }

  Widget _buildListaFotos() {
    if (widget.fotos != null && widget.fotos.length > 0) {
      return new Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 0),
        color: new Color(0xFFFFFFFF),
        child: new Row(
          children: <Widget>[
            new Expanded(
                child: new SizedBox(
                  child: new ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.fotos.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new GestureDetector(
                          onTap: (){
                            imageClick2(
                                index,
                                index,
                                widget.fotos[index]);
                          },
                          child:
                          new Hero(
                            tag: "image${index}${index}", child: new Container(
                              margin: EdgeInsets.only(left: 4, bottom: 16),
                              decoration: new BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.0),
                                child: FadeInImage(
                                  image: FileImage(File(widget.fotos[index])),
                                  placeholder: MemoryImage(kTransparentImage),
                                  fit: BoxFit.cover,
                                  height: 58,
                                  width: 58,
                                ),
                              )),)
                      );
                    },
                  ),
                  height: 72,
                ))
          ],
        ),
      );
    } else {
      return new Container();
    }
  }

  Future imageClick2(int hero, int hero2,String caminho) async {
    if(widget.finalizacaoChamado == true)
      {
        fotosAmplia.length = widget.fotos.length;
        fotosAmplia = await Navigator.push<List<String>>(
          context,
          new HeroDialogRoute(
            builder: (BuildContext context) {
              return new ZFotoAnimationView(
                image: widget.image,
                hero: hero,
                hero2: hero2,
                finalizacaoChamado:widget.finalizacaoChamado,
                caminho: caminho,
                fotos: widget.fotos,
              );
            },
          ),
        );
        if(widget.fotos != fotosAmplia)
        {
          widget.fotos = fotosAmplia;
        }
        setState((){});
      }
    else if (widget.finalizacaoChamado == false && widget.image != null)
    {
      fotosAmplia.length = widget.fotos.length;
      fotosAmplia = await Navigator.push<List<String>>(
        context,
        new HeroDialogRoute(
          builder: (BuildContext context) {
            return new ZFotoAnimationView(
              image: widget.image,
              hero: hero,
              hero2: hero2,
              finalizacaoChamado:widget.finalizacaoChamado,
              caminho: caminho,
              fotos: widget.fotos,
            );
          },
        ),
      );
      if(widget.fotos != fotosAmplia)
      {
        widget.fotos = fotosAmplia;
      }
      setState((){});
    }
    else if (widget.finalizacaoChamado == false && widget.image == null)
      {
        print("ERRO: A 'finalizacaoChamado' = false, não pode com 'image' = null");

      }

  }

  Future showDialogBottomFoto() {
    return showModalBottomSheet<String>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (builder) {
          return new Container(
              height: 130,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(top: 18, bottom: 8),
                        child: new Text(
                          "ADICIONAR FOTO",
                          style: new TextStyle(color: Color(0xff999999)),
                        ),
                      )
                    ],
                  ),
                  new Divider(color: Color(0xffCECECE)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Expanded(
                          flex: 5,
                          child: new GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              openCamera();
                            },
                            child: new Container(
                              color: Colors.transparent,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: new Icon(
                                      Icons.camera_alt,
                                      color: widget.primaryColorApp,
                                    ),
                                  ),
                                  new Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    child: new Text(
                                      "Usar Câmera",
                                      style: new TextStyle(
                                          color: Color(0xff999999)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      new Expanded(
                          flex: 5,
                          child: new GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                openGallery();
                              },
                              child: new Container(
                                color: Colors.transparent,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Container(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: new Icon(
                                        Icons.add_photo_alternate,
                                        color: widget.primaryColorApp,
                                      ),
                                    ),
                                    new Container(
                                      margin: const EdgeInsets.only(top: 6),
                                      child: new Text(
                                        "Usar Galeria",
                                        style: new TextStyle(
                                            color: Color(0xff999999)),
                                      ),
                                    )
                                  ],
                                ),
                              )))
                    ],
                  ),
                ],
              ));
        });
  }

  Future<String> openCamera() async {
    var buscarfoto = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (buscarfoto != null) {
      foto = buscarfoto.absolute.path;
      setState(() {
        widget.fotos.add(foto);
        if(widget.scrollControllerTela != null)
          {
            Future.delayed(new Duration(milliseconds: 500), () {
              Timer(
                  Duration(milliseconds: 200),
                      () =>
                      widget.scrollControllerTela
                          .jumpTo(
                          widget.scrollControllerTela.position.maxScrollExtent));
            });
          }
      });
    }
  }

  Future<String> openGallery() async {
    var buscarfoto = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (buscarfoto != null) {
      foto = buscarfoto.absolute.path;
      setState(() {
        widget.fotos.add(foto);
        if(widget.scrollControllerTela != null)
        {
          Future.delayed(new Duration(milliseconds: 500), () {
            Timer(
                Duration(milliseconds: 200),
                    () =>
                    widget.scrollControllerTela
                        .jumpTo(
                        widget.scrollControllerTela.position.maxScrollExtent));
          });
        }
      });
    }
  }

  Widget _buildObrigatoriedadeFoto() {
    if (widget.fotoObrigatoria == true && widget.fotos.length == 0) {
      return new Container(
          padding: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
          child: new Text(
            "*",
            style: new TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ));
    }
    else {
      return new Container();
    }
  }


}

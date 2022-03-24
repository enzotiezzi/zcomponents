import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/utils/documento-status.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/utils/svg.dart';
import 'package:z_components/components/z-documentos/view/lista-documentos-view.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/colaborador-documento-viewmodel.dart';
import '../../z-alert-dialog.dart';

class ListaDocumentos extends StatefulWidget {
  String idColaborador;
  String token;
  String keyGeniusScan;
  List<ColaboradorDocumentoViewModel> colaboradorDocumentoViewModel;
  Function(ColaboradorDocumentoViewModel) retornarListaDocumentos;
  bool iconeInformativo;
  String textoInformativo;
  String tituloTextoInformativo;

  ListaDocumentos(
      {this.idColaborador,
      this.token,
      this.keyGeniusScan,
      this.colaboradorDocumentoViewModel,
      this.retornarListaDocumentos,
      this.iconeInformativo = false,
      this.textoInformativo = "",
      this.tituloTextoInformativo = ""});

  @override
  _ListaDocumentosState createState() => _ListaDocumentosState();
}

class _ListaDocumentosState extends State<ListaDocumentos> {
  DialogUtils _dialogUtils;
  ListaDocumentosView _view;
  bool _documentoAtualizado = true;

  @override
  void initState() {
    _view = ListaDocumentosView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: [_retornarDialogInformativo()],
        leading: new IconeVoltar(),
        centerTitle: true,
        title: new Text("DOCUMENTOS"),
      ),
      body: _listarDocumentos(),
    );
  }

  Widget _retornarDialogInformativo() {
    if (widget.iconeInformativo) {
      return new IconButton(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: _view.state.context,
              builder: (context) {
                return new ZAlertDialog(
                  zDialog: ZDialog.normal,
                  colorLine: new Color(0xFF1e26f7),
                  child: new Column(
                    children: [
                      new Container(
                          margin: const EdgeInsets.only(top: 16, bottom: 4),
                          child: new Icon(
                            Icons.info,
                            color: const Color(0xFF1e26f7),
                          )),
                      new Container(
                        margin: const EdgeInsets.only(
                          bottom: 8,
                          left: 16,
                          right: 16,
                        ),
                        child: new Text(
                          widget.tituloTextoInformativo,
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.all(16),
                        child: new Text(
                          "${widget.textoInformativo}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      new Divider(
                        height: 1.0,
                      ),
                      new FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: new Container(
                          margin: const EdgeInsets.only(bottom: 8, top: 8),
                          child: new Container(
                            width: 270,
                            height: 22,
                            margin: const EdgeInsets.only(top: 8),
                            child: new Text(
                              "OK",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MainStyle.get(context)
                                      .fontSizeLeadinCancelar,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        icon: new Icon(
          Icons.info,
          size: 28,
        ),
      );
    } else {
      return new Container();
    }
  }

  Widget _listarDocumentos() {
    return new ListView.builder(
        padding: EdgeInsets.only(top: 20.0),
        itemCount: _view.listaDocumentos.length,
        itemBuilder: (context, index) {
          var item = _view.listaDocumentos[index];
          return new GestureDetector(
            onTap: () async {
               _view.abrirDocumento(index);
            },
            child: new Container(
              margin: const EdgeInsets.only(top: 1),
              height: 50,
              decoration: new BoxDecoration(
                color: const Color(0xffffffff),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        height: 34,
                        width: 51,
                        decoration: (item.imagemDocumento == null)
                            ? BoxDecoration()
                            : BoxDecoration(
                                image: new DecorationImage(
                                    image:
                                        new Image.memory(item.imagemDocumento)
                                            .image)),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: new Text(
                          item.nomeDocumento,
                          style: new TextStyle(
                            color: const Color(0xff000000),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: [
                      _retornarStatus(index),
                      new Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: new Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.black,size: 14,))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _retornarImagem(Uint8List image) {
    if (image == null)
      return new Container(
        margin: EdgeInsets.only(left: 16.0),
        height: 34,
        width: 51,
      );
    else
      return new Container(
        margin: EdgeInsets.only(left: 16.0),
        height: 34,
        width: 51,
        child: Image.memory(image),
      );
  }

  Widget _retornarStatus(int index) {
    if (_view.listaDocumentos[index].porcentagemStatusPreenchimento < 1) {
      return new Container(
        decoration: new ShapeDecoration(
            shape: new CircleBorder(), color: Colors.transparent),
        child: new Icon(
          Icons.ac_unit,
          color: Colors.transparent,
          size: 9,
        ),
      );
    } else if (_view.listaDocumentos[index].porcentagemStatusPreenchimento >
            0 &&
        _view.listaDocumentos[index].porcentagemStatusPreenchimento < 100) {
      return new Container(
        decoration:
            new ShapeDecoration(shape: new CircleBorder(), color: Colors.amber),
        child: new Icon(
          Icons.ac_unit,
          color: Colors.transparent,
          size: 9,
        ),
      );
    } else {
      return new Container(
        decoration:
            new ShapeDecoration(shape: new CircleBorder(), color: Colors.green),
        child: new Icon(
          Icons.ac_unit,
          color: Colors.transparent,
          size: 9,
        ),
      );
    }
  }

  Widget _buildIconeStatus(String status) {
    switch (status.toUpperCase()) {
      case DocumentoStatusUtils.APROVADO:
        return new SvgPicture.asset(
          SvgUtils.STATUSAPROVADO,
          semanticsLabel: 'status-aprovado.svg',
          placeholderBuilder: (context) => Icon(Icons.error),
        );
        break;

      case DocumentoStatusUtils.REPROVADO:
        return new SvgPicture.asset(
          SvgUtils.STATUSREPROVADO,
          semanticsLabel: 'status-reprovado.svg',
          placeholderBuilder: (context) => Icon(Icons.error),
        );
        break;

      case DocumentoStatusUtils.NAO_ENVIADO:
        return new SvgPicture.asset(
          SvgUtils.STATUSNAOENVIADO,
          semanticsLabel: 'status-nao-enviado.svg',
          placeholderBuilder: (context) => Icon(Icons.error),
        );
        break;

      case DocumentoStatusUtils.PARCIALMENTE_ENVIADO:
        return new SvgPicture.asset(
          SvgUtils.STATUSPARCIALMENTEENVIADO,
          semanticsLabel: 'status-parcialmente-enviado.svg',
          placeholderBuilder: (context) => Icon(Icons.error),
        );
        break;

      case DocumentoStatusUtils.AGUARDANDO_VALIDACAO:
        return new SvgPicture.asset(
          SvgUtils.STATUSAGUARDANDOVALIDACAO,
          semanticsLabel: "status-aguardando-avaliacao.svg",
          placeholderBuilder: (context) => Icon(Icons.error),
        );
        break;
    }
  }
}

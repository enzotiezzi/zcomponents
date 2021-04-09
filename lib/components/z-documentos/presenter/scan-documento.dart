import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:z_components/components/utils/svg.dart';
import 'package:z_components/components/z-documentos/view/scan-documento-view.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/view-model/colaborador-documento-viewmodel.dart';

class ScanDocumentos extends StatefulWidget {
  ColaboradorDocumentoViewModel colaboradorDocumentoViewModel;
  String token;
  String keyGeniusScan;

  ScanDocumentos(
      {this.colaboradorDocumentoViewModel, this.token, this.keyGeniusScan});

  @override
  _ScanDocumentosState createState() => _ScanDocumentosState();
}

class _ScanDocumentosState extends State<ScanDocumentos> {
  ZScanDocumentoView _view;

  @override
  void initState() {
    _view = ZScanDocumentoView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            new Text("${widget.colaboradorDocumentoViewModel.nomeDocumento}"),
      ),
      body: _scanDocumentos(),
    );
  }

  Widget _scanDocumentos() {
    return new ListView(
      children: [
        new Container(
          margin: EdgeInsets.only(top: 20.0),
          child: _montarHeader("DADOS DO DOCUMENTO"),
        ),
        new Container(
          margin: EdgeInsets.only(bottom: 20),
          child: new Column(
            children: _montarListaDinamicaDocumentos(),
          ),
        ),
        _montarHeader("IMAGENS DO DOCUMENTO"),
        _buildAddFoto(),
        _buildListaFotos(),
        _montarBotaoFinalizar()
      ],
    );
  }

  List<Widget> _montarListaDinamicaDocumentos() {
    List<Widget> lista = new List();
    for (int i = 0; i < _view.listaRespostasUsuario.length; i++) {
      var item = widget.colaboradorDocumentoViewModel.campos[i];
      if (item.tipoValorCampo == "date") {
        lista.add(new Container(
          child: new ZInputGeneric(
            themeData: Theme.of(context),
            titulo: item.nomeCampo,
            tipoTeclado: TextInputType.number,
            comMascara: true,
            textMask: "##/##/####",
            controllerInputPadrao:
                TextEditingController(text: _view.listaRespostasUsuario[i]),
            onChange: (text) {
              if (text.length == 10) {
                _view.listaRespostasUsuario[i] = text.trim();
              }
            },
          ),
        ));
      } else {
        lista.add(new Container(
          child: new ZInputGeneric(
            themeData: Theme.of(context),
            titulo: item.nomeCampo,
            inputPadraoFocus: null,
            controllerInputPadrao:
                TextEditingController(text: _view.listaRespostasUsuario[i]),
            onChange: (text) {
              _view.listaRespostasUsuario[i] = text.trim();
            },
          ),
        ));
      }
    }
    return lista;
  }

  Widget _montarHeader(String text) {
    return new Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Color(0xffF0F0F0)))),
      padding: EdgeInsets.only(left: 15.0, bottom: 8.0, top: 16.0),
      alignment: Alignment.centerLeft,
      child: new Text(text,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildAddFoto() {
    int quantidadeMaximaDePaginas = int.parse(
        widget.colaboradorDocumentoViewModel.qtdePaginaUpload.split("/")[1]);
    if (quantidadeMaximaDePaginas > _view.fotos.length) {
      return new Container(
        margin: EdgeInsets.only(bottom: (_view.fotos.length > 0) ? 0 : 80),
        child: new InkWell(
          onTap: () {
            _view.scanDocumento();
          },
          child: new Container(
              color: Colors.white,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 8, top: 10, bottom: 10),
                          child: new Text(
                            "ESCANEAR DOCUMENTO",
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Theme.of(context).accentColor),
                          )),
                      new Container(
                        margin: EdgeInsets.only(
                            right: (_view.fotos.length == 0) ? 0 : 16),
                        child: _buildSvgScanIcon(),
                      ),
                    ],
                  )
                ],
              )),
        ),
      );
    } else {
      return new Container();
    }
  }

  Widget _buildSvgScanIcon() {
    return SvgPicture.asset(
      SvgUtils.ASSETSCANICON,
      semanticsLabel: 'scan-doc.svg',
      placeholderBuilder: (context) => Icon(Icons.error),
      color: Theme.of(context).accentColor,
    );
  }

  Widget _buildListaFotos() {
    if (_view.fotos != null && _view.fotos.length > 0) {
      return new Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 0),
        color: new Color(0xFFFFFFFF),
        child: new Row(
          children: <Widget>[
            new Expanded(
                child: new SizedBox(
              child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _view.fotos.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return new GestureDetector(
                      onTap: () {
                        _view.expandirImagem(index, index, _view.fotos[index]);
                      },
                      child: new Hero(
                        tag: "image${index}${index}",
                        child: new Container(
                            margin: EdgeInsets.only(left: 4, bottom: 16),
                            decoration: new BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: FadeInImage(
                                image: MemoryImage(_view.fotos[index]),
                                placeholder:
                                    MemoryImage(_view.kTransparentImage),
                                fit: BoxFit.cover,
                                height: 58,
                                width: 58,
                              ),
                            )),
                      ));
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

  Widget _montarBotaoFinalizar() {
    return new Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: new RaisedButton(
        padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
        color: Color(0xff801F92),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        onPressed: () async {
          bool validado = _view.mapearCamposComRespostas();

          if (validado &&
              (widget.colaboradorDocumentoViewModel.imagemObrigatoria &&
                  _view.fotos.length > 0)) {
            _view.dialogUtils.showProgressDialog();
            await _view.enviarFotos();
            await _view.salvarDocumentos();
          } else {
            _view.dialogUtils.showAlertDialogErro("Erro", "Dados incorretos!");
          }
        },
        child: new Text(
          "SALVAR",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    );
  }
}

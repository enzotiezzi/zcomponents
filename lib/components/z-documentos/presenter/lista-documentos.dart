import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:z_components/components/utils/documento-status.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/utils/svg.dart';
import 'package:z_components/components/z-documentos/view/lista-documentos-view.dart';
import 'package:z_components/view-model/colaborador-documento-viewmodel.dart';

class ListaDocumentos extends StatefulWidget {
  String idColaborador;
  String token;
  String keyGeniusScan;
  List<ColaboradorDocumentoViewModel> colaboradorDocumentoViewModel;
  Function(ColaboradorDocumentoViewModel) retornarListaDocumentos;

  ListaDocumentos(
      {this.idColaborador,
      this.token,
      this.keyGeniusScan,
      this.colaboradorDocumentoViewModel,
      this.retornarListaDocumentos});

  @override
  _ListaDocumentosState createState() => _ListaDocumentosState();
}

class _ListaDocumentosState extends State<ListaDocumentos> {
  ListaDocumentosView _view;

  @override
  void initState() {
    _view = ListaDocumentosView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconeVoltar(),
        centerTitle: true,
        title: new Text("DOCUMENTOS"),
      ),
      body: _listarDocumentos(),
    );
  }

  Widget _listarDocumentos() {
    return new ListView.builder(
        padding: EdgeInsets.only(top: 20.0),
        itemCount: _view.listaDocumentos.length,
        itemBuilder: (context, index) {
          var item = _view.listaDocumentos[index];
          return new GestureDetector(
            onTap: () async {
              await _view.atualizarDocumento(index);
            },
            child: new Container(
              margin: EdgeInsets.only(top: 1),
              height: 50,
              //margin: EdgeInsets.only(left: 16.0),
              decoration: new BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(left: 16.0),
                        height: 34,
                        width: 51,
                        decoration: (item.imagemDocumento == null)
                            ? BoxDecoration()
                            : BoxDecoration(
                                image: DecorationImage(
                                    image: Image.memory(item.imagemDocumento)
                                        .image)),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: new Text(
                          item.nomeDocumento,
                          style: new TextStyle(
                            color: Color(0xff000000),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    margin: EdgeInsets.only(right: 16),
                    child: new Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _buildIconeStatus(String status) {
    switch (status.toUpperCase()) {
      case DocumentoStatusUtils.APROVADO:
        return SvgPicture.asset(
          SvgUtils.STATUSAPROVADO,
          semanticsLabel: 'status-aprovado.svg',
          placeholderBuilder: (context) => Icon(Icons.error),
        );
        break;

      case DocumentoStatusUtils.REPROVADO:
        return SvgPicture.asset(
          SvgUtils.STATUSREPROVADO,
          semanticsLabel: 'status-reprovado.svg',
          placeholderBuilder: (context) => Icon(Icons.error),
        );
        break;

      case DocumentoStatusUtils.NAO_ENVIADO:
        return SvgPicture.asset(
          SvgUtils.STATUSNAOENVIADO,
          semanticsLabel: 'status-nao-enviado.svg',
          placeholderBuilder: (context) => Icon(Icons.error),
        );
        break;

      case DocumentoStatusUtils.PARCIALMENTE_ENVIADO:
        return SvgPicture.asset(
          SvgUtils.STATUSPARCIALMENTEENVIADO,
          semanticsLabel: 'status-parcialmente-enviado.svg',
          placeholderBuilder: (context) => Icon(Icons.error),
        );
        break;

      case DocumentoStatusUtils.AGUARDANDO_VALIDACAO:
        return SvgPicture.asset(
          SvgUtils.STATUSAGUARDANDOVALIDACAO,
          semanticsLabel: "status-aguardando-avaliacao.svg",
          placeholderBuilder: (context) => Icon(Icons.error),
        );
        break;
    }
  }
}

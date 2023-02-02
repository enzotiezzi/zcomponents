import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-documentos/view/lista-documentos-contratacao-viewmodel.dart';
import 'package:z_components/view-model/contratacao-documento-viewmodel.dart';

class ListaDocumentosContratacao extends StatefulWidget {
  String? idColaborador;
  String? token;
  String? keyGeniusScan;
  List<ContratacaoDocumentoViewModel>? colaboradorDocumentoViewModel;
  Function(ContratacaoDocumentoViewModel)? retornarListaDocumentos;
  bool? iconeInformativo;
  String? textoInformativo;
  String? tituloTextoInformativo;

  ListaDocumentosContratacao(
      {this.idColaborador,
        this.token,
        this.keyGeniusScan,
        this.colaboradorDocumentoViewModel,
        this.retornarListaDocumentos,
        this.iconeInformativo = false,
        this.textoInformativo = "",
        this.tituloTextoInformativo = ""});

  @override
  _ListaDocumentosContratacaoState createState() => _ListaDocumentosContratacaoState();
}

class _ListaDocumentosContratacaoState extends State<ListaDocumentosContratacao> {
  late DialogUtils _dialogUtils;
  late ListaDocumentosContratacaoView _view;
  bool _documentoAtualizado = true;

  @override
  void initState() {
    _view = ListaDocumentosContratacaoView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }





}
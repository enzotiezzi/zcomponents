import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/arquivo/arquivo-service.dart';
import 'package:z_components/api/arquivo/i-arquivo-service.dart';
import 'package:z_components/api/colaborador-documento/i-colaborador-documento-service.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-documentos/presenter/lista-documentos.dart';
import 'package:z_components/components/z-documentos/presenter/scan-documento.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/colaborador-documento-viewmodel.dart';

class ListaDocumentosView extends IView<ListaDocumentos> {
  IColaboradorDocumentoService _colaboradorDocumentoService;

  DialogUtils _dialogUtils;

  IArquivoService _arquivoService;

  List<ColaboradorDocumentoViewModel> listaDocumentos =
      new List<ColaboradorDocumentoViewModel>();

  ListaDocumentosView(State<ListaDocumentos> state) : super(state);

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() async {
    _dialogUtils = new DialogUtils(state.context);
    _arquivoService = new ArquivoService(state.widget.token);
    await _buscarListaDocumentos();
  }

  Future<void> _buscarListaDocumentos() async {
    _dialogUtils.showProgressDialog();
    var lista = await _colaboradorDocumentoService
        .listarDocumentosColaborador(state.widget.idColaborador);
    if (lista != null) {
      for (int i = 0; i < lista.length; i++) {
        var doc = await _arquivoService.buscarAnexo(lista[i].idImagemDocumento);

        lista[i].imagemDocumento = base64Decode(doc.conteudo);
      }

      if (state.mounted) {
        state.setState(() {
          listaDocumentos = lista;
        });
      }
      _dialogUtils.dismiss();
    }
  }

  Future<void> atualizarDocumento(int index) async {
    bool atualizou = await navigate(ScanDocumentos(
      colaboradorDocumentoViewModel: listaDocumentos[index],
      keyGeniusScan: state.widget.keyGeniusScan,
      token: state.widget.token,
    ));
    if (atualizou != null && atualizou) {
      await _buscarListaDocumentos();
    }
  }
}

import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/arquivo/i-arquivo-service.dart';
import 'package:z_components/api/colaborador-documento/i-colaborador-documento-service.dart';
import 'package:z_components/components/z-documentos/presenter/lista-documentos-contratacao.dart';
import 'package:z_components/i-view.dart';

class ListaDocumentosContratacaoView extends IView<ListaDocumentosContratacao> {
  ListaDocumentosContratacaoView(State<ListaDocumentosContratacao> state) : super(state);

  late IColaboradorDocumentoService _colaboradorDocumentoService;
  late IArquivoService _arquivoService;




  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() {
    // TODO: implement initView
    throw UnimplementedError();
  }


}

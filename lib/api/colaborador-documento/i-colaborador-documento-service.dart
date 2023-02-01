

import 'package:z_components/api/input/colaborador-documento-input.dart';
import 'package:z_components/view-model/colaborador-documento-campo-viewmodel.dart';
import 'package:z_components/view-model/colaborador-documento-imagem-viewmodel.dart';
import 'package:z_components/view-model/colaborador-documento-viewmodel.dart';

abstract class IColaboradorDocumentoService {
  Future<List<ColaboradorDocumentoViewModel>?> listarDocumentosColaborador(
      String idColaborador);

  Future<bool?> enviarDocumento(
      ColaboradorDocumentoInput colaboradorDocumentoInput,
      String idColaborador,
      String idDocumento);

  Future<List<ColaboradorDocumentoImagemViewModel>?> listarDocumentoImagem(
      String idColaborador, String idDocumento);

  Future<List<ColaboradorDocumentoCampoViewModel>?> listarDocumentoCampo(
      String idColaborador, String idDocumento);
}

import 'dart:convert';

import 'package:z_components/api/input/colaborador-documento-input.dart';
import 'package:z_components/view-model/colaborador-documento-campo-viewmodel.dart';
import 'package:z_components/view-model/colaborador-documento-imagem-viewmodel.dart';
import 'package:z_components/view-model/colaborador-documento-viewmodel.dart';

import '../api-settings.dart';
import '../service.dart';
import 'i-colaborador-documento-service.dart';

class ColaboradorDocumentoService extends Service
    implements IColaboradorDocumentoService {
  static final String _URL = "${ApiSettings.ENDPOINT_API_V1}/colaborador";

  ColaboradorDocumentoService(String token) : super(token);

  @override
  Future<List<ColaboradorDocumentoViewModel>?> listarDocumentosColaborador(
      String idColaborador) async {
    try {
      var url = "$_URL/colaborador/documento/$idColaborador";

      var response = await request(url, Service.HTTP_GET);

      return (json.decode(response!.body) as List)
          .map((x) => ColaboradorDocumentoViewModel.fromJson(x))
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool?> enviarDocumento(
      ColaboradorDocumentoInput colaboradorDocumentoInput,
      String idColaborador,
      String idDocumento) async {
    try {
      var url = "$_URL/colaborador/documento/$idColaborador/$idDocumento";

      var map = colaboradorDocumentoInput.toMap();

      var response = await request(url, Service.HTTP_POST,
          body: map);
      return response?.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<ColaboradorDocumentoImagemViewModel>?> listarDocumentoImagem(
      String idColaborador, String idDocumento) async {
    try {
      var url = "$_URL/colaborador/documento/imagem/$idColaborador/$idDocumento";

      var response = await request(url, Service.HTTP_GET);

      return (json.decode(response!.body) as List)
          .map((x) => ColaboradorDocumentoImagemViewModel.fromJson(x))
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ColaboradorDocumentoCampoViewModel>?> listarDocumentoCampo(
      String idColaborador, String idDocumento) async {
    try {
      var url = "$_URL/colaborador/documento/campo/$idColaborador/$idDocumento";

      var response = await request(url, Service.HTTP_GET);

      return (json.decode(response!.body) as List)
          .map((x) => ColaboradorDocumentoCampoViewModel.fromJson(x))
          .toList();
    } catch (e) {
      return null;
    }
  }
}

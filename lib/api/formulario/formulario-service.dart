import 'dart:convert';

import 'package:z_components/api/formulario/i-formulario-service.dart';
import 'package:z_components/api/service.dart';
import 'package:z_components/view-model/z-dynamic-form-viewmodel.dart';
import 'package:z_components/view-model/z-dynamic-model-viewmodel.dart';

class FormularioService extends Service implements IFormularioService {
  var _URL = "https://gateway-dev.zellar.com.br/api/v1";

  FormularioService(String token) : super(token);

  @override
  Future<List<ZDynamicModelViewModel>?> buscarFormularios() async {
    try {
      var url = "$_URL/formulario/modelo";

      var response = await request(url, Service.HTTP_GET);

      return (json.decode(response!.body) as List)
          .map((x) => ZDynamicModelViewModel.fromJson(x))
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ZDynamicFormViewModel>?> montarFormulario(String idModelo) async {
    try {
      var url = "$_URL/formulario/modelo/$idModelo/atributos";

      var response = await request(url, Service.HTTP_GET);

      return (json.decode(response!.body) as List)
          .map((x) => ZDynamicFormViewModel.fromJson(x))
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ZDynamicFormViewModel?> enviarFormulario(
      ZDynamicFormViewModel solicitacao) async {
    try {
      var url = "$_URL/formulario/valores";

      var response =
      await request(url, Service.HTTP_POST, body: solicitacao.toMap());

      return ZDynamicFormViewModel.fromJson(json.decode(response!.body));
    } catch (e) {
      return null;
    }
  }

}

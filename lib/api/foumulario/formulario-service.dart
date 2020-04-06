import 'dart:convert';

import 'package:z_components/api/foumulario/i-formulario-service.dart';
import 'package:z_components/api/service.dart';
import 'package:z_components/view-model/z-dynamic-form-viewmodel.dart';

class FormularioService extends Service implements IFormularioService {
  var _URL = "https://identity-server-dev.zellar.com.br/apis";

  FormularioService(String token) : super(token);

  @override
  Future<List<ZDynamicFormViewModel>> buscarFormularios() async {
    try {
      var url = "$_URL/formulario/Modelo";

      var response = await request(url, Service.HTTP_GET);

      return (json.decode(response.body) as List)
          .map((x) => ZDynamicFormViewModel.fromJson(x))
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ZDynamicFormViewModel>> montarFormulario(String idModelo) async {
    try {
      var url = "$_URL/formulario/modelo/$idModelo/atributo";

      var response = await request(url, Service.HTTP_GET);

      return (json.decode(response.body) as List)
          .map((x) => ZDynamicFormViewModel.fromJson(x))
          .toList();
    } catch (e) {
      return null;
    }
  }

}

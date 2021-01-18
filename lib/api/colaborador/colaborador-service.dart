import 'dart:convert';
import 'package:z_components/view-model/colaborador-viewmodel.dart';

import '../service.dart';
import 'i-colaborador-service.dart';

class ColaboradorService extends Service implements IColaboradorService {
  static final String _URL = "http://zellarm.azurewebsites.net/apis";

  ColaboradorService(String token) : super(token);

  @override
  Future<List<ColaboradorViewModel>> buscarColaboradores(String re) async {
    try {
      var url = "$_URL/colaboradores/listar-colaboradores-por-re/$re";

      var response = await request(url, Service.HTTP_GET);

      return (json.decode(response.body) as List)
          .map((x) => ColaboradorViewModel.fromJson(x))
          .toList();
    } catch (e) {
      return null;
    }
  }
}
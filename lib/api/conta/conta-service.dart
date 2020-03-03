import 'dart:convert';

import 'package:z_components/api/conta/i-conta-service.dart';
import 'package:z_components/api/service.dart';
import 'package:z_components/view-model/conta-view-model.dart';

class ContaService extends Service implements IContaServce {
  String _URL = "https://identity-server-dev.zellar.com.br/apis/minhas-contas";

  ContaService(String token) : super(token);

  @override
  Future<List<ContaViewModel>> listarContasUsuario() async {
    try {
      var res = await request(_URL, Service.HTTP_GET);

      var lista = (json.decode(res.body) as List)
          .map((x) => ContaViewModel.fromJson(x))
          .toList();

      return lista;
    } catch (e) {
      return null;
    }
  }
}

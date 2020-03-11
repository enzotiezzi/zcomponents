import 'dart:convert';

import 'package:z_components/api/conta/i-conta-service.dart';
import 'package:z_components/api/service.dart';
import 'package:z_components/view-model/conta-view-model.dart';

class ContaService extends Service implements IContaServce {
  String _URL = "https://identity-server-dev.zellar.com.br/account/contas";

  ContaService(String token) : super(token);

  @override
  Future<List<ContaViewModel>> listarContasUsuario() async {
    try {
      var res = await request(
          "https://identity-server-dev.zellar.com.br/apis/minhas-contas",
          Service.HTTP_GET);

      var lista = (json.decode(res.body) as List)
          .map((x) => ContaViewModel.fromJson(x))
          .toList();

      return lista;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> associarConta(String idConta) async {
    try {
      var url = "$_URL/associar";

      var res =
          await request(url, Service.HTTP_POST, body: {"idConta": idConta});

      return res.statusCode == 200;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ContaViewModel> localizarConta(String codigoAtivacao) async {
    try {
      var url = "$_URL/localizar";

      var res = await request(url, Service.HTTP_POST,
          body: {"codigoAtivacao": codigoAtivacao});

      return ContaViewModel.fromJson(json.decode(res.body));
    } catch (e) {
      return null;
    }
  }
}

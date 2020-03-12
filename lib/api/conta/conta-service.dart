import 'dart:convert';

import 'package:z_components/api/conta/i-conta-service.dart';
import 'package:z_components/api/service.dart';
import 'package:z_components/view-model/conta-view-model.dart';

class ContaService extends Service implements IContaServce {
  String _URL = "https://identity-server-dev.zellar.com.br/apis";

  ContaService(String token) : super(token);

  @override
  Future<List<ContaViewModel>> listarContasUsuario() async {
    try {
      var res = await request("$_URL/minhas-contas", Service.HTTP_GET);

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
      var url = "$_URL/account/contas/associar";

      var res = await request(url, Service.HTTP_POST, body: idConta);

      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<ContaViewModel> localizarConta(String codigoAtivacao) async {
    try {
      var url = "$_URL/account/contas/localizar";

      var res = await request(url, Service.HTTP_POST, body: codigoAtivacao);

      return ContaViewModel.fromJson(json.decode(res.body));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> trocarContaAtiva(String idConta) async {
    try{
      var url = "$_URL/troca-conta/$idConta";

      var res = await request(url, Service.HTTP_POST);

      return res.statusCode == 200;
    }catch(e){
      return false;
    }
  }
}

import 'dart:convert';

import 'package:z_components/api/endereco/i-endereco-service.dart';
import 'package:z_components/api/service.dart';
import 'package:z_components/view-model/endereco-viewmodel.dart';

class EnderecoService extends Service implements IEnderecoService {
  EnderecoService() : super("");

  @override
  Future<EnderecoViewModel> buscarEnderecoPorCEP(String cep) async {
    try {
      cep = cep.replaceAll("-", "");

      var url = "https://viacep.com.br/ws/$cep/json";

      var response = await request(url, Service.HTTP_GET, defaultAuthorizationHeader: false, timeout: 20);

      return EnderecoViewModel.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }
}

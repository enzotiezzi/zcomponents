import 'dart:convert';

import 'package:z_components/api/service.dart';
import 'package:z_components/settings/api-settings.dart';
import 'package:z_components/view-model/posicao-alocacao-sequencia-viewmodel.dart';
import 'package:http/http.dart' as http;

class QuadroPessoalService extends Service {
  final String token;
  final String idConta;

  var _URL = "${ApiSettings.ENDPOINT}/quadro-pessoal";

  QuadroPessoalService(this.token, this.idConta) : super(token);

  Future<List<PosicaoAlocacaoSequenciaViewModel?>?> buscarSequencia(
      String? idColaborador) async {
    try {
      var url = "$_URL/buscar-sequencia/$idColaborador/$idConta}";

      var response = await http.get(Uri.parse(url), headers: headers);

      var lista = (json.decode(response.body) as List)
          .map((x) => PosicaoAlocacaoSequenciaViewModel.fromJson(x));

      return lista.toList();
    } catch (e) {
      return null;
    }
  }

  Future<List<String>?> listarTouFColaborador(String? idColaborador) async {
    try {
      var url = "$_URL/listar-touf-colaborador/$idColaborador/$idConta";

      var response = await http.get(Uri.parse(url), headers: headers);

      List<String> lista =[];

      (json.decode(response.body) as List).forEach((x) {
        lista.add(x);
      });

      return lista;
    } catch (e) {
      return null;
    }
  }
}

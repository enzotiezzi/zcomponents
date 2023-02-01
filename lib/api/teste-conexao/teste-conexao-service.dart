import 'dart:collection';

import 'package:z_components/settings/api-settings.dart';

import '../service.dart';
import 'i-teste-conexao-service.dart';

class TesteConexaoService extends Service implements ITesteConexaoService {
  Map<String, String> headers = new HashMap<String, String>();

  final String _URL = "${ApiSettings.ENDPOINT_API}/apontamento-online";

  TesteConexaoService() : super("");


  Future<bool?> testarConexao() async {
    try {
      var url = "${ApiSettings.ENDPOINT_API}/zponto/isAlive";

      var response = await request(url, Service.HTTP_GET, timeout: 4);

      return response?.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

}

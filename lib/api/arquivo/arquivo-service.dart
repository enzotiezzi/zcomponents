import 'dart:convert';
import 'package:z_components/api/arquivo/i-arquivo-service.dart';
import 'package:z_components/api/service.dart';
import 'package:z_components/settings/api-settings.dart';
import 'package:z_components/view-model/arquivo-viewmodel.dart';
import 'package:z_components/view-model/foto-detalhe-viewmodel.dart';

class ArquivoService extends Service implements IArquivoService {
  static final String _URL = "${ApiSettings.ENDPOINT_API_V1}/arquivos/arquivos";

  ArquivoService(String token) : super(token);

  @override
  Future<String> enviarImagem(ArquivoViewModel arquivoViewModel) async {
    try {
      var url = "$_URL";

      var response =
          await request(url, Service.HTTP_POST, body: arquivoViewModel.toMap());

      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> atualizarImagem(ArquivoViewModel arquivoViewModel) async {
    try {
      var url = "$_URL";

      var response =
          await request(url, Service.HTTP_PUT, body: arquivoViewModel.toMap());

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return null;
    }
  }

  Future<FotoDetalheViewModel> buscarAnexo(String idAnexo) async {
    try {
      var url = "$_URL/$idAnexo";

      var response = await request(url, Service.HTTP_GET);

      return FotoDetalheViewModel.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }
}

import 'dart:convert';
import 'package:z_components/api/service.dart';
import 'package:z_components/interface/i-zcolaborador-service.dart';
import 'package:z_components/settings/api-settings.dart';
import 'package:z_components/view-model/colaborador-viewmodel.dart';
import 'package:http/http.dart' as http;

class ZColaboradorService extends Service implements IZColaboradorService {
  final String token;
  final String idConta;
  final String cpf;

  static final String _URL_API_COLABORADOR =
      "${ApiSettings.ENDPOINT}/colaboradores";

  ZColaboradorService(this.token, this.idConta, this.cpf) : super(token);

  @override
  Future<ColaboradorViewModel?> buscarPerfilColaborador() async {
    try {
      var url =
          "$_URL_API_COLABORADOR/totem-buscar-perfil-colaborador/$cpf/$idConta";

      var response = await http.get(Uri.parse(url), headers: headers);

      return new ColaboradorViewModel.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }
}

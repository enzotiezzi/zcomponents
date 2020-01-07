import 'dart:convert';
import 'package:z_components/api/service.dart';
import 'package:z_components/interface/i-zusuario-service.dart';
import 'package:z_components/settings/api-settings.dart';
import 'package:http/http.dart' as http;
import 'package:z_components/view-model/usuario-viewmodel.dart';

class ZUsuarioService extends Service implements IZUsuarioService {
  final String token;
  final String idConta;
  final String cpf;

  static final String _URL_API_COLABORADOR =
      "${ApiSettings.ENDPOINT}/colaboradores";

  ZUsuarioService(this.token, this.idConta, this.cpf) : super(token);

  @override
  Future<UsuarioViewModel> buscarPerfilUsuario() async {
    try {
      var url =
          "$_URL_API_COLABORADOR/totem-buscar-perfil-colaborador/$cpf/$idConta";

      var response = await http.get(url, headers: headers);

      return new UsuarioViewModel.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }
}

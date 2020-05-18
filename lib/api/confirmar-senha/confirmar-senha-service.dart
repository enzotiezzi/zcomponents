import 'dart:convert';
import 'package:z_components/api/confirmar-senha/i-confirmar-senha-service.dart';
import 'package:z_components/api/service.dart';
import 'package:z_components/view-model/confirmar-senha-viewmodel.dart';

class ConfirmarSenhaService extends Service implements IConfirmarSenhaService {
  static final String _URL = "https://identity-server-dev.zellar.com.br/";

  ConfirmarSenhaService(String token) : super(token);

  @override
  Future<bool> validarSenha(ConfirmarSenhaViewModel confirmarSenhaViewModel) async {
    try {
      var url = "$_URL/apis/seguranca/pin";

      var response = await request(url, Service.HTTP_POST, body: confirmarSenhaViewModel.toMap());

      return response.statusCode == 200;
    } catch (e) {
      return null;
    }
  }

}

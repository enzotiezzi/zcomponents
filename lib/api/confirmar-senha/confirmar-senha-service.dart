import 'dart:convert';
import 'package:z_components/api/confirmar-senha/i-confirmar-senha-service.dart';
import 'package:z_components/api/service.dart';
import 'package:z_components/view-model/confirmar-senha-viewmodel.dart';

class ConfirmarSenhaService extends Service implements IConfirmarSenhaService {
  static final String _URL = "";

  ConfirmarSenhaService(String token) : super(token);

  @override
  Future<String> validarSenha(ConfirmarSenhaViewModel confirmarSenhaViewModel) async {
    try {
      var url = "$_URL";

      var response = await request(url, Service.HTTP_POST, body: confirmarSenhaViewModel.toMap());

      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

}

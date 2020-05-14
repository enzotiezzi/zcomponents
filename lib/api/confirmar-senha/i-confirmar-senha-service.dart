import 'package:z_components/view-model/confirmar-senha-viewmodel.dart';

abstract class IConfirmarSenhaService{
  Future<String> validarSenha(ConfirmarSenhaViewModel confirmarSenhaViewModel);
}
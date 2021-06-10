import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/modulo/detalhe-usuario.dart';
import 'package:z_components/i-view.dart';

class DetalheUsuarioView extends IView<DetalheUsuario> {
  DetalheUsuarioView(State<DetalheUsuario> state) : super(state);

  String titulo = "";
  String textModificar = '';

  TextEditingController emailController = new TextEditingController();
  FocusNode emailFocus = new FocusNode();
  TextEditingController dataController = new TextEditingController();
  FocusNode dataFocus = new FocusNode();
  TextEditingController nomeController = new TextEditingController();
  FocusNode nomeFocus = new FocusNode();
  TextEditingController moduloController = new TextEditingController();
  FocusNode moduloFocus = new FocusNode();
  TextEditingController perfilController = new TextEditingController();
  FocusNode perfilFocus = new FocusNode();
  TextEditingController telefoneController = new TextEditingController();
  FocusNode telefoneFocus = new FocusNode();

  String hintNomePerfil = '';
  String hintStatus = '';
  String hintDataExpiracao = '';
  String hintDataVinculo = '';
  bool preencheuDataExpiracao = false;
  List<String> itensMenu = [];

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() {
    if (state.widget.editarDados) {
      itensMenu = [_definirTexto()];
    } else {
      itensMenu = ["Editar dados", _definirTexto()];
    }
    _preencherDados();
  }

  String _definirTexto() {
    if (state.widget.appUsuarioContaViewModel.status == "Ativo") {
      return "Revogar";
    } else {
      return "Ativar";
    }
  }

  Widget _preencherDados() {
    titulo = state.widget.appUsuarioContaViewModel.app.nome;
    perfilController.text = state.widget.appUsuarioContaViewModel.perfil.nome ??
        "Não contém perfil";
    telefoneController.text =
        state.widget.appUsuarioContaViewModel.usuario.telefone;
    emailController.text = state.widget.appUsuarioContaViewModel.usuario.email;
    nomeController.text = state.widget.appUsuarioContaViewModel.usuario.nome;
    if (state.widget.appUsuarioContaViewModel.status == "Ativo") {
      textModificar = "REVOGAR ACESSO";
    } else {
      textModificar = "ATIVAR ACESSO";
    }
  }

  bool validarCampos() {
    if (preencheuDataExpiracao) {
      return true;
    } else {
      return false;
    }
  }

  Function cliqueModificarAcesso() {}

  Function editarOnPressed() {}
}

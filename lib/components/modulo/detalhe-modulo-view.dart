import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/fluxo-admin/usuarios.dart';
import 'package:z_components/components/modulo/detalhe-modulo.dart';
import 'package:z_components/components/utils/novo_token.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';


class DetalheModuloView extends IView<DetalheModulo>{
  DetalheModuloView(State<DetalheModulo> state) : super(state);

  IContasService contasService;

  @override
  Future<void> afterBuild() {
  }

  @override
  Future<void> initView() {
    _preencherDados();
    contasService = new ContasService(NovoToken.newToken);
    if (state.widget.editarDados) {
      Future.delayed(Duration(seconds: 1), () {
        FocusScope.of(state.context).requestFocus(perfilFocus);
      });
    }
  }

  TextEditingController dataExpiracaoController = new TextEditingController();
  FocusNode dataExpiracaoFocus = new FocusNode();
  TextEditingController dataController = new TextEditingController();
  FocusNode dataFocus = new FocusNode();
  TextEditingController statusController = new TextEditingController();
  FocusNode statusFocus = new FocusNode();
  TextEditingController moduloController = new TextEditingController();
  FocusNode moduloFocus = new FocusNode();
  TextEditingController perfilController = new TextEditingController();
  FocusNode perfilFocus = new FocusNode();
  TextEditingController dataVinculoController = new TextEditingController();
  FocusNode dataVinculoFocus = new FocusNode();

  bool editarDados = false;
  String titulo = "";
  bool cliqueEditar=false;
  String hintNomePerfil= '';
  String hintStatus='';
  String hintDataExpiracao='';
  String hintDataVinculo='';
  bool preencheuDataExpiracao=false;
  String textModificar='';



  Widget _preencherDados(){
    titulo = state.widget.appUsuarioContaViewModel.app.nome;
    perfilController.text = "Não contém perfil";
    dataVinculoController.text = _validarDataVinculo();
    dataExpiracaoController.text = _validarDataExpiracao();
    statusController.text = state.widget.appUsuarioContaViewModel.status;
    if(state.widget.appUsuarioContaViewModel.status == "Ativo"){
      textModificar = "REVOGAR ACESSO";
    }else{
      textModificar="ATIVAR ACESSO";
    }
  }
  String _validarDataVinculo(){
    if(state.widget.appUsuarioContaViewModel.dataVinculo != null){
      return UtilData.obterDataDDMMAAAA(DateTime.parse(state.widget.appUsuarioContaViewModel.dataVinculo));

    }else{
      return "Nunca";
    }
  }

  String _validarDataExpiracao(){
    if(state.widget.appUsuarioContaViewModel.dataInativacao != null){
      return UtilData.obterDataDDMMAAAA(DateTime.parse(state.widget.appUsuarioContaViewModel.dataInativacao));
    }else{
      return "Nunca";
    }
  }

  bool validarCampos(){
    if(preencheuDataExpiracao){
      return true;
    }else{
      return false;
    }
  }

  Function editarOnPressed(){
    if(validarCampos()){
      return (){
        Navigator.pushReplacement(
            state.context,
            MaterialPageRoute(
                builder: (_)=>Usuarios(themeData: Theme.of(state.context),)));
      };
    }else{
      return null;
    }
  }

  Function cliqueModificarAcesso(AppUsuarioContaViewModel appUsuarioConta){
    if(textModificar.contains("REVOGAR")){
      return (){
        state.setState(() {
          appUsuarioConta.status = "Inativo";
          contasService.modificarAcesso(appUsuarioConta);
        });
      };
    }else{
      return(){
        state.setState(() {
          appUsuarioConta.status = "Ativo";
          contasService.modificarAcesso(appUsuarioConta);
        });
      };
    }
  }

  String listarAppsVinculados(List<AppUsuarioContaViewModel> lista) {
    String appsFormatados = "";
    if (lista != null && lista.length != 0) {
      for (int i = 0; i < lista.length; i++) {
        if (i == 0) {
          appsFormatados = "$appsFormatados- ${lista[i].app.nome}";
        } else {
          appsFormatados = "$appsFormatados, ${lista[i].app.nome}";
        }
      }
    } else {
      appsFormatados = "Sem apps vinculados";
    }
    return appsFormatados;
  }

}
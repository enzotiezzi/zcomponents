import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/fluxo-admin/usuarios.dart';
import 'package:z_components/components/modulo/detalhe-modulo.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';


class DetalheModuloView extends IView<DetalheModulo>{
  DetalheModuloView(State<DetalheModulo> state) : super(state);

  AppUsuarioContaViewModel appUsuarioContaViewModel;

  @override
  Future<void> afterBuild() {
  }

  @override
  Future<void> initView() {
    appUsuarioContaViewModel = state.widget.appUsuarioContaViewModel;
    _preencherDados();

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



  Widget _preencherDados(){
    titulo = appUsuarioContaViewModel.nomeApp;
    perfilController.text = appUsuarioContaViewModel.nomePerfil ?? "Não contém perfil";
    dataVinculoController.text = _validarDataVinculo();
    dataExpiracaoController.text = _validarDataExpiracao();
    statusController.text = appUsuarioContaViewModel.status;
  }
  String _validarDataVinculo(){
    if(appUsuarioContaViewModel.dataVinculo != null){
      return UtilData.obterDataDDMMAAAA(DateTime.parse(appUsuarioContaViewModel.dataVinculo));

    }else{
      return "Nunca";
    }
  }

  String _validarDataExpiracao(){
    if(appUsuarioContaViewModel.dataExpiracao != null){
      return UtilData.obterDataDDMMAAAA(DateTime.parse(appUsuarioContaViewModel.dataExpiracao));
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

}
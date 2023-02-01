import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/fluxo-admin/detalhe-usuario.dart';
import 'package:z_components/i-view.dart';

class DetalheUsuarioView extends IView<DetalheUsuario>{
  DetalheUsuarioView(State<DetalheUsuario> state) : super(state);

  String titulo = "";
  String textModificar='';

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

  String hintNomePerfil= '';
  String hintStatus='';
  String hintDataExpiracao='';
  String hintDataVinculo='';
  bool preencheuDataExpiracao=false;

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() {
    _preencherDados();
    throw UnimplementedError();

  }

   _preencherDados(){
    titulo = state.widget.appUsuarioContaViewModel?.app?.nome ?? "";
    perfilController.text = "Não contém perfil";
    dataVinculoController.text = _validarDataVinculo();
    dataExpiracaoController.text = _validarDataExpiracao();
    statusController.text = state.widget.appUsuarioContaViewModel?.status ?? "";
    if(state.widget.appUsuarioContaViewModel?.status == "Ativo"){
      textModificar = "REVOGAR ACESSO";
    }else{
      textModificar="ATIVAR ACESSO";
    }
  }

  bool validarCampos(){
    if(preencheuDataExpiracao){
      return true;
    }else{
      return false;
    }
  }

  String _validarDataVinculo(){
    if(state.widget.appUsuarioContaViewModel?.dataVinculo != null){
      return UtilData.obterDataDDMMAAAA(DateTime.parse(state.widget.appUsuarioContaViewModel!.dataVinculo!));
    }else{
      return "Nunca";
    }
  }

  String _validarDataExpiracao(){
    if(state.widget.appUsuarioContaViewModel?.dataInativacao != null){
      return UtilData.obterDataDDMMAAAA(DateTime.parse(state.widget.appUsuarioContaViewModel!.dataInativacao!));
    }else{
      return "Nunca";
    }
  }

  Function? cliqueModificarAcesso(){}

  Function? editarOnPressed(){

  }

}
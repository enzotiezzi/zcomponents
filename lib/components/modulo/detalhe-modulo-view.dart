import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/fluxo-admin/usuarios.dart';
import 'package:z_components/components/modulo/detalhe-modulo.dart';
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
    contasService = new ContasService(
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjA5MGQ1Y2IyMTNiYmQ2OTVhMWZmNmFlNWUwMzUxNGI2IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MjI2Nzc4NTgsImV4cCI6MTYyMjY4MTQ1OCwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpHZXN0b3IiLCJzdWIiOiIwMjFmOTE4Mi0zZjQxLTRmMGEtYWFkYy00MDc3NmU2MGQwNGMiLCJhdXRoX3RpbWUiOjE2MjI2Nzc4NTgsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiIzS0U2RUNEUlRIR0dYQURBTUNXR1pHQUVEWDJEM1lPTCIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiM2YyYmRjYmItNzY0Zi00OGM3LTBjMzMtMDhkN2NmNjNlNDViIiwiaWRDb2xhYm9yYWRvciI6IjE1ODQyQzJFLUM3RDctNERENS04RkE5LUZFMzNDQkQ2NENFQyIsInByZWZlcnJlZF91c2VybmFtZSI6IjQyNi45MTAuMjU4LTYxIiwiZW1haWwiOiJsdWl6Lmx1Y2lhQHplbGxhci5jb20uYnIiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJMdWl6IEx1Y2lhIE5ldG8iLCJwaG9uZV9udW1iZXIiOiIxMTk0ODQ4NDEyMCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.gVaovaMX068eElkkg6CRE0lMup9OJHsMshjFuqbcpQueg4OvtQe6hVknDH80lwqac_Klw5jlMwR4Uqsw2Hyc7fypySKqh05fBtDL0MW3_YmnlHTo_AhkC5LuMtKu6xo0yNfGJmy1OxtgH8tMa-nXE-S5FFHX_08rYrks91rwWoAbXGG7sEdfH7jlvIpng1loWqUOhoOI-MPJ6yJI3R9i2pso4p28Djxg-NZn2Vk_DIDnXlDQGfz4O0uMUfyuAcIpg36vPOYYeAdH4cHYKi5FYoutNrkRhNtw3z_QvLdp3fqFBIpN5reYkRT_2qH85VleHc9yUh3t6LyJAx35CSvkfA");
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

}
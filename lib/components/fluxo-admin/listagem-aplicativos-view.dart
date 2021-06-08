

import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/conta/i-conta-service.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/fluxo-admin/listagem-aplicativos.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/app-view-model.dart';

class ListagemAplicativosView extends IView<ListagemAplicativos>{
  ListagemAplicativosView(State<ListagemAplicativos> state) : super(state);

  IContasService contasService;
  List<AppViewModel> listaModulos = [];

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() async{
    contasService = new ContasService(
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjA5MGQ1Y2IyMTNiYmQ2OTVhMWZmNmFlNWUwMzUxNGI2IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MjMwODYxMDMsImV4cCI6MTYyMzA4OTcwMywiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpHZXN0b3IiLCJzdWIiOiIwMjFmOTE4Mi0zZjQxLTRmMGEtYWFkYy00MDc3NmU2MGQwNGMiLCJhdXRoX3RpbWUiOjE2MjIyMTE0OTUsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiIzS0U2RUNEUlRIR0dYQURBTUNXR1pHQUVEWDJEM1lPTCIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiM2YyYmRjYmItNzY0Zi00OGM3LTBjMzMtMDhkN2NmNjNlNDViIiwiaWRDb2xhYm9yYWRvciI6IjE1ODQyQzJFLUM3RDctNERENS04RkE5LUZFMzNDQkQ2NENFQyIsInByZWZlcnJlZF91c2VybmFtZSI6IjQyNi45MTAuMjU4LTYxIiwiZW1haWwiOiJsdWl6Lmx1Y2lhQHplbGxhci5jb20uYnIiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJMdWl6IEx1Y2lhIE5ldG8iLCJwaG9uZV9udW1iZXIiOiIxMTk0ODQ4NDEyMCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.owrqh3-7XxE4G9yqzoJp6gBxzYH9BmWtW6wbOAb0FTJW3WIVeFGMWgqsVuH40BGgWZUuk9p_FR-uY8HgkPIxVpM_tB573bI_iVnVDkGvmfBZfZVQDs7brkxDANKYbK7Wz9fdpfohnImOOboyUqulRVo-pGoEFDoC3P_h_XH9ilX18GLPOgNvcDCyCQ5KoMhmZ8bgjLzojBAU2hWQk21fgPG_87jn7fXdkusadM8pQmDYlBlLg5p_nLG4L2VfTnyTCYhQuqlmOtWa9XXeMxbakYBOhGUBVMFdKy5y0sk6bhmreYioFPebTMYu-zcyTI6XDERzawlgZEmJFX8j15v56Q");
    await buscarAplicativos();
  }

  Future<void> buscarAplicativos ()async{
    var res = await contasService.listarAplicativos(state.widget.moduloContaViewModel.idModulo);
    if(res !=null){
      state.setState(() {
        listaModulos = res;
      });
    }

  }
}
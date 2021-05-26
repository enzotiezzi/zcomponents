import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/usuarios/usuarios.dart';
import 'package:z_components/view-model/usuario-conta-viewmodel.dart';

import '../../i-view.dart';

class UsuariosView extends IView<Usuarios> {
  UsuariosView(State<Usuarios> state) : super(state);

  IContasService contasService;
  List<UsuarioContaViewModel> listaUsuarios = [];
  GlobalKey<ZSearchBarState> keySearchBar = new GlobalKey();
  SearchOptions searchOptions = new SearchOptions();
  PaginationMetaData paginationMetaData = new PaginationMetaData();
  ScrollController scrollController;

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() async {
    contasService = new ContasService(
        "eyJhbGciOiJSUzI1NiIsImtpZCI6ImM0YWQ5OTFiMzk0NDIzNzEzZDlkZGI3ZWQzYzRlN2Q3IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MjIwNTYyOTMsImV4cCI6MTYyMjA1OTg5MywiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpHZXN0b3IiLCJzdWIiOiIwMjFmOTE4Mi0zZjQxLTRmMGEtYWFkYy00MDc3NmU2MGQwNGMiLCJhdXRoX3RpbWUiOjE2MjIwNDAwOTcsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiIzS0U2RUNEUlRIR0dYQURBTUNXR1pHQUVEWDJEM1lPTCIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiNDg2YTQ5YjMtNDdkMS00ZDc2LTgwZGYtMDc5ZWI4MmQ2ZDhmIiwiaWRDb2xhYm9yYWRvciI6IjE1ODQyQzJFLUM3RDctNERENS04RkE5LUZFMzNDQkQ2NENFQyIsInByZWZlcnJlZF91c2VybmFtZSI6IjQyNi45MTAuMjU4LTYxIiwiZW1haWwiOiJsdWl6Lmx1Y2lhQHplbGxhci5jb20uYnIiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJMdWl6IEx1Y2lhIE5ldG8iLCJwaG9uZV9udW1iZXIiOiIxMTk0ODQ4NDEyMCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.GNqSkzPiwZLSY0YjLhbib2A7sWw04Zn5sD_nuqn7zItdyn9dO9XZYO0SGvaeRTMhZbo-nJnINwHTDbJHY9cQuFOskStzmpwgVD2AK0lO23Z4ZwoD5kZS4Uq4uTXGgzhQ6bTA6RTCoiEV_nmi_tQDhUX7tZVWlhmlG3GH9asgYhAjLYtvhGVVqiHKFwzZhzme3Oq3DtMsap4vPmKOST2xfKZ_w9UDj7dSnos0Ku5ejnGmaZHqDoiAVLkHjeoWyg6GkkjoLWqB1uNslwCIpRMW-ITCKfq5m78ja8uh3I_vQd1jrbFZUiL_q-NkqIQdSi7ystFXQJfs9dBWXNzVuCZ2yA");
    await buscarListaUsuarios(searchOptions);
    scrollController = new ScrollController();
    scrollController.addListener(onScroll);
  }

  Future<void> buscarListaUsuarios(SearchOptions searchOptions) async {
    var res = await contasService.listarUsuariosConta(searchOptions);
    if (res != null) {
      if (state.mounted) {
        state.setState(() {
          listaUsuarios = res.body;
          paginationMetaData = res.paginationMetaData;
        });
      }
    }
  }

  Future<void> onScroll() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (this.paginationMetaData.hasNext) {
        await buscarListaUsuarios(this.searchOptions);

        this.searchOptions.pagination.pageNumber++;
      }
    }
  }
}

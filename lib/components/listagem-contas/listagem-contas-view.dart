import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/conta-v2-viewmodel.dart';

import '../../i-view.dart';
import 'listagem-contas.dart';

class ListagemContasView extends IView<ListagemContas> {
  ListagemContasView(State<ListagemContas> state) : super(state);

  GlobalKey<ZSearchBarState> keySearchBar = new GlobalKey();
  List<ContaV2ViewModel> listaContas = [];
  SearchOptions searchOptions = new SearchOptions();
  PaginationMetaData paginationMetaData = new PaginationMetaData();
  ScrollController scrollController;
  IContasService contasService;

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() async {
    contasService = new ContasService(
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjA5MGQ1Y2IyMTNiYmQ2OTVhMWZmNmFlNWUwMzUxNGI2IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MjMwOTM5NTIsImV4cCI6MTYyMzA5NzU1MiwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpHZXN0b3IiLCJzdWIiOiIwMjFmOTE4Mi0zZjQxLTRmMGEtYWFkYy00MDc3NmU2MGQwNGMiLCJhdXRoX3RpbWUiOjE2MjIyMTE0OTUsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiIzS0U2RUNEUlRIR0dYQURBTUNXR1pHQUVEWDJEM1lPTCIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiM2YyYmRjYmItNzY0Zi00OGM3LTBjMzMtMDhkN2NmNjNlNDViIiwiaWRDb2xhYm9yYWRvciI6IjE1ODQyQzJFLUM3RDctNERENS04RkE5LUZFMzNDQkQ2NENFQyIsInByZWZlcnJlZF91c2VybmFtZSI6IjQyNi45MTAuMjU4LTYxIiwiZW1haWwiOiJsdWl6Lmx1Y2lhQHplbGxhci5jb20uYnIiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJMdWl6IEx1Y2lhIE5ldG8iLCJwaG9uZV9udW1iZXIiOiIxMTk0ODQ4NDEyMCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.gqFfdK1ot_KFPV68qcUj7YFRviCv_SJHQ0QFOn9zBousU3HK3XL7EW40pZUUHLouYFaup_aetYToPPoOc1lSdvga_7fP5zrmdC7LkeC_IYu7OpZylsqwUjN7tQI72EOce67iw_TE1b7RKd7ebZBFUOLEg2NIkylkQnyUdnBxfMY8OvN1DdtwUgGaes0njRRL9Raff9xvKBgO_nRVe5q3UgXkhOBoQSPoFySxetNLD_HXOWs_sbTl1oSIhbjNqIdGvvpOto7qpXt6t3drLfZm5U_whV9LI2kj21SYV_ZgZlgc3dF7GFJCeX9FLsOjgnX63ObnZSjIDBYy-W-UiJfaxQ");

    scrollController = new ScrollController();
    scrollController.addListener(onScroll);
    await buscarListaContas(searchOptions);
  }

  Future<void> buscarListaContas(SearchOptions searchOptions,
      {bool scrollPage}) async {
    var res = await contasService.listarContas(searchOptions);

    if (res != null) {
      if (scrollPage != null) {
        listaContas = listaContas + res.body;
      } else {
        listaContas = res.body;
      }
      if (state.mounted) {
        state.setState(() {
          paginationMetaData = res.paginationMetaData;
          this.searchOptions = searchOptions;
        });
      }
    }
  }

  Future<void> onScroll() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (this.paginationMetaData.hasNext) {
        this.searchOptions.pagination.pageNumber++;
        await buscarListaContas(this.searchOptions, scrollPage: true);
      }
    }
  }

  String listarAppsVinculados(List<AppUsuarioContaViewModel> lista) {
    String appsFormatados = "";
    if (lista != null && lista.length != 0) {
      for (int i = 0; i < lista.length; i++) {
        if (i == 0) {
          appsFormatados = "$appsFormatados- ${lista[i].app.nome ?? ""}";
        } else {
          appsFormatados = "$appsFormatados, ${lista[i].app.nome ?? ""}";
        }
      }
    } else {
      appsFormatados = "Sem apps vinculados";
    }
    return appsFormatados;
  }
}

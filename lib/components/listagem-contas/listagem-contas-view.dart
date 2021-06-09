import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
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
  DialogUtils _dialogUtils;

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() async {
    _dialogUtils = DialogUtils(state.context);
    _dialogUtils.showProgressDialog();
    contasService = new ContasService(
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjA5MGQ1Y2IyMTNiYmQ2OTVhMWZmNmFlNWUwMzUxNGI2IiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MjMxNzk0MzMsImV4cCI6MTYyMzE4MzAzMywiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpHZXN0b3IiLCJzdWIiOiIwMjFmOTE4Mi0zZjQxLTRmMGEtYWFkYy00MDc3NmU2MGQwNGMiLCJhdXRoX3RpbWUiOjE2MjMxNzk0MzMsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiIzS0U2RUNEUlRIR0dYQURBTUNXR1pHQUVEWDJEM1lPTCIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiOGU2ZWI2MzItYjcwNy00MTNmLWExNTItM2NmZmQxZjk4MmI1IiwiaWRDb2xhYm9yYWRvciI6IjE1ODQyQzJFLUM3RDctNERENS04RkE5LUZFMzNDQkQ2NENFQyIsInByZWZlcnJlZF91c2VybmFtZSI6IjQyNi45MTAuMjU4LTYxIiwiZW1haWwiOiJsdWl6Lmx1Y2lhQHplbGxhci5jb20uYnIiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJMdWl6IEx1Y2lhIE5ldG8iLCJwaG9uZV9udW1iZXIiOiIxMTk0ODQ4NDEyMCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.WnByyGSY_SLToMMFOjAjFGaHzZq-LwNlz5QGmYg4fuzwfNvic5RFk_GQ0CgNOS1zd15c8dVG8Yik7FgbmEI8_lYlVJ0qWDQoXNRxgtNZFfoTWDBtsswqbIIFzvjT68jmjETUyHWS6At7eeDRXh6MZxg8jK8utpBb8rME6Kj4w0JDvocEbzgByx54EpVj9yq1XCjGvBEjXo34iuShbqbZ3xp2ufq7Izl1Pyvi4Wr3DGj9ORbbsmO3AJd87tDxgTl2Ofm2N3lF1eZzZoWI5SJoI6MHIPiHoNEi3fcF2B52WSjLdRjcVGC_8i_WdH-gs7WIdsvRamU8_qKuAQgpby6xvA");

    scrollController = new ScrollController();
    scrollController.addListener(onScroll);
    await buscarListaContas(searchOptions);
    _dialogUtils.dismiss();
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

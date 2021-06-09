import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/utils/novo_token.dart';
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
    contasService = new ContasService(NovoToken.newToken);

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
          appsFormatados = "$appsFormatados- ${lista[i].app.nomeExibicao ?? ""}";
        } else {
          appsFormatados = "$appsFormatados, ${lista[i].app.nomeExibicao ?? ""}";
        }
      }
    } else {
      appsFormatados = "Sem apps vinculados";
    }
    return appsFormatados;
  }
}

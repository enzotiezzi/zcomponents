import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/arquivo/arquivo-service.dart';
import 'package:z_components/api/arquivo/i-arquivo-service.dart';
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
  late PaginationMetaData paginationMetaData = new PaginationMetaData();
  ScrollController scrollController = ScrollController();
  late IContasService contasService;
  late IArquivoService _arquivoService;
  late DialogUtils _dialogUtils;

  @override
  Future<void> afterBuild() async{
  }

  @override
  Future<void> initView() async {
    _dialogUtils = DialogUtils(state.context);
    _dialogUtils.showProgressDialog();

    contasService = new ContasService(state.widget.token!);
    _arquivoService = new ArquivoService(state.widget.token!);

    scrollController = new ScrollController();
    scrollController.addListener(onScroll);
    OrderByExpression order = new OrderByExpression();
    order.propertyName = "Conta.Nome";
    order.orientation = "ASC";
    searchOptions.orders = [order];
    await buscarListaContas(searchOptions);
    _dialogUtils.dismiss();
  }

  Future<void> buscarListaContas(SearchOptions searchOptions,
      {bool? scrollPage}) async {
    var res = await contasService.listarContas(searchOptions);

    if (res != null) {
      if (scrollPage != null) {
        listaContas = listaContas + res.body!;
      } else {
        listaContas = res.body!;
      }
      for (int i = 0; i < listaContas.length; i++) {
        var doc = await _arquivoService.buscarAnexo(listaContas[i].idConta!);

        if (doc != null) {
          listaContas[i].conta!.logo = base64Decode(doc.conteudo!);
        }
      }
      if (state.mounted) {
        state.setState(() {
          paginationMetaData = res.paginationMetaData!;
          this.searchOptions = searchOptions;
        });
      }
    }
  }

  Future<void> onScroll() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (this.paginationMetaData.hasNext!) {
        OrderByExpression order = new OrderByExpression();
        order.propertyName = "Conta.Nome";
        order.orientation = "ASC";
        searchOptions.orders = [order];
        this.searchOptions.pagination!.pageNumber! +1;
        await buscarListaContas(this.searchOptions, scrollPage: true);
      }
    }
  }

  String listarAppsVinculados(List<dynamic>? lista) {
    String appsFormatados = "";
    if (lista != null && lista.length != 0) {
      for (int i = 0; i < lista.length; i++) {
        if (i == 0) {
          appsFormatados =
              "$appsFormatados- ${lista[i].app?.nomeExibicao ?? ""}";
        } else {
          appsFormatados =
              "$appsFormatados, ${lista[i].app?.nomeExibicao ?? ""}";
        }
      }
    } else {
      appsFormatados = "Sem apps vinculados";
    }
    return appsFormatados;
  }
}

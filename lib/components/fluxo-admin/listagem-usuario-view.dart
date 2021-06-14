import 'package:flutter/material.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-response.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/utils/novo_token.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';

class ListagemUsuariosView extends IView<ListagemUsuarios> {
  ListagemUsuariosView(State<ListagemUsuarios> state) : super(state);

  IContasService contasService;
  String titulo = "";
  List<AppUsuarioContaViewModel> listaUsuarioPorApp;
  GlobalKey<ZSearchBarState> keySearchBar = new GlobalKey();
  SearchOptions searchOptions = new SearchOptions();
  PaginationMetaData paginationMetaData = new PaginationMetaData();
  ScrollController scrollController;
  bool icons2 = true;
  DialogUtils _dialogUtils;

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() async {
    _dialogUtils = new DialogUtils(state.context);
    contasService = new ContasService(NovoToken.newToken);
    _dialogUtils.showProgressDialog();
    OrderByExpression order = new OrderByExpression();
    order.propertyName = "Usuario.Nome";
    order.orientation = "ASC";
    searchOptions.orders = [order];
    await buscarUsuario(searchOptions);
    _dialogUtils.dismiss();
    titulo = state.widget.appViewModel.nome;
  }

  Future<void> buscarUsuario(SearchOptions searchOptions,
      {bool scrollPage}) async {
    var res = await contasService.listarUsuariosPorModuloEApp(
        state.widget.appViewModel.idModulo,
        state.widget.appViewModel.idApp,
        searchOptions);

    if (res != null) {
      listaUsuarioPorApp = res.body;
      state.setState(() {});
    }
  }

  Future<void> onScroll() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (this.paginationMetaData.hasNext) {
        OrderByExpression order = new OrderByExpression();
        order.propertyName = "Usuario.Nome";
        order.orientation = "ASC";
        searchOptions.orders = [order];
        this.searchOptions.pagination.pageNumber++;

        await buscarUsuario(this.searchOptions, scrollPage: true);
      }
    }
  }
}

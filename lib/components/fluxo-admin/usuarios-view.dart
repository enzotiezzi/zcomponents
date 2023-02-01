import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/usuarios.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/utils/novo_token.dart';
import 'package:z_components/view-model/usuario-conta-viewmodel.dart';

import '../../i-view.dart';

class UsuariosView extends IView<Usuarios> {
  UsuariosView(State<Usuarios> state) : super(state);

  late IContasService contasService;
  List<UsuarioContaViewModel>? listaUsuarios = [];
  GlobalKey<ZSearchBarState> keySearchBar = new GlobalKey();
  SearchOptions searchOptions = new SearchOptions();
  PaginationMetaData paginationMetaData = new PaginationMetaData();
  late ScrollController scrollController;
  late DialogUtils _dialogUtils;

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() async {
    OrderByExpression order = new OrderByExpression();
    order.propertyName = "Usuario.Nome";
    order.orientation = "ASC";
    searchOptions.orders = [order];
    _dialogUtils = new DialogUtils(state.context);
    contasService = new ContasService(NovoToken.newToken);
    _dialogUtils.showProgressDialog();
    await buscarListaUsuarios(searchOptions);
    scrollController = new ScrollController();
    scrollController.addListener(onScroll);
    _dialogUtils.dismiss();
  }

  Future<void> buscarListaUsuarios(SearchOptions searchOptions,
      {bool? scrollPage}) async {
    var res = await contasService.listarUsuariosConta(searchOptions);

    if (res != null) {
      if (scrollPage != null) {
        listaUsuarios = listaUsuarios! + res.body!;
      } else {
        listaUsuarios = res.body;
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
        order.propertyName = "Usuario.Nome";
        order.orientation = "ASC";
        searchOptions.orders = [order];
        this.searchOptions.pagination!.pageNumber! +1;
        await buscarListaUsuarios(this.searchOptions, scrollPage: true);
      }
    }
  }
}

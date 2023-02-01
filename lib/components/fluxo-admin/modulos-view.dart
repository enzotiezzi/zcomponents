import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/modulos.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/utils/novo_token.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/modulo-conta-viewmodel.dart';

class ModulosView extends IView<Modulos> {
  ModulosView(State<Modulos> state) : super(state);

  List<ModuloContaViewModel>? listaModulos = [];
  GlobalKey<ZSearchBarState> keySearchBar = new GlobalKey();
  SearchOptions searchOptions = new SearchOptions();
  PaginationMetaData paginationMetaData = new PaginationMetaData();
  late ScrollController scrollController;
  late IContasService contasService;
  late DialogUtils _dialogUtils;

  @override
  Future<void> initView() async {
    _dialogUtils = new DialogUtils(state.context);

    contasService = new ContasService(NovoToken.newToken);
    _dialogUtils.showProgressDialog();
    OrderByExpression order = new OrderByExpression();
    order.propertyName = "Modulo.Nome";
    order.orientation = "ASC";
    searchOptions.orders = [order];
    await buscarListaModulos(searchOptions);

    scrollController = new ScrollController();
    scrollController.addListener(onScroll);
    _dialogUtils.dismiss();
  }


  Future<void> buscarListaModulos(SearchOptions searchOptions,
      {bool? scrollPage}) async {
    var res = await contasService.listarModulosConta(searchOptions);

    if (res != null) {
      if (scrollPage != null) {
        listaModulos = listaModulos! + res.body!;
        print(listaModulos);
      } else {
        listaModulos = res.body;
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
        order.propertyName = "Modulo.Nome";
        order.orientation = "ASC";
        searchOptions.orders = [order];
        this.searchOptions.pagination!.pageNumber! +1;

        await buscarListaModulos(this.searchOptions, scrollPage: true);
      }
    }
  }

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }
}

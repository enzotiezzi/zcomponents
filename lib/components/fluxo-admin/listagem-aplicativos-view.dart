import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/conta/i-conta-service.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/listagem-aplicativos.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/utils/novo_token.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/app-view-model.dart';

class ListagemAplicativosView extends IView<ListagemAplicativos> {
  ListagemAplicativosView(State<ListagemAplicativos> state) : super(state);

  IContasService contasService;
  GlobalKey<ZSearchBarState> keySearchBar = new GlobalKey();
  List<AppViewModel> listaModulos = [];
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
    _dialogUtils.showProgressDialog();
    contasService = new ContasService(NovoToken.newToken);
    scrollController = new ScrollController();
    scrollController.addListener(onScroll);
    await buscarAplicativos(searchOptions);
    _dialogUtils.dismiss();
  }

  Future<void> buscarAplicativos(SearchOptions searchOptions,
      {bool scrollPage}) async {
    var res = await contasService.listarAplicativos(
        searchOptions, state.widget.moduloContaViewModel.idModulo);
    if (res != null) {
      state.setState(() {
        listaModulos = res.body;
      });
    }
  }

  Future<void> onScroll() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (this.paginationMetaData.hasNext) {
        this.searchOptions.pagination.pageNumber++;
        await buscarAplicativos(this.searchOptions, scrollPage: true);
      }
    }
  }
}

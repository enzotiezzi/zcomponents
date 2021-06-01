import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/modulos.dart';
import 'package:z_components/i-view.dart';

class ModulosView extends IView<Modulos>{
  ModulosView(State<Modulos> state) : super(state);

  List listaModulos = [];
  GlobalKey<ZSearchBarState> keySearchBar = new GlobalKey();
  SearchOptions searchOptions = new SearchOptions();
  PaginationMetaData paginationMetaData = new PaginationMetaData();
  ScrollController scrollController;

  @override
  Future<void> initView() {
    //await buscarListaModulos(searchOptions);
    scrollController = new ScrollController();
    scrollController.addListener(onScroll);
  }

  @override
  Future<void> afterBuild() {
  }
  Future<void> onScroll() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (this.paginationMetaData.hasNext) {
        this.searchOptions.pagination.pageNumber++;

        //await buscarListaModulos(this.searchOptions, scrollPage: true);
      }
    }
  }


}
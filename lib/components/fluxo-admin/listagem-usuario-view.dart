import 'package:flutter/material.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-response.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario.dart';
import 'package:z_components/components/utils/novo_token.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';

class ListagemUsuariosView extends IView<ListagemUsuarios>{
  ListagemUsuariosView(State<ListagemUsuarios> state) : super(state);

  IContasService contasService;
  String titulo ="";
  List<AppUsuarioContaViewModel> listaUsuarioPorApp;
  GlobalKey<ZSearchBarState> keySearchBar = new GlobalKey();
  SearchOptions searchOptions = new SearchOptions();
  PaginationMetaData paginationMetaData = new PaginationMetaData();
  ScrollController scrollController;
  bool icons2 = true;

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() async{
    contasService = new ContasService(NovoToken.newToken);
    await buscarUsuario();
   titulo = state.widget.appViewModel.nome;
  }

  Future<void> buscarUsuario() async {
    var res = await contasService.listarUsuariosPorModuloEApp(state.widget.appViewModel.idModulo,state.widget.appViewModel.idApp);

    if (res != null) {
        listaUsuarioPorApp = res.body;
        print(listaUsuarioPorApp);

    }
  }

}
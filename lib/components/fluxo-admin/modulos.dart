import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/listagem-aplicativos.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario.dart';
import 'package:z_components/components/fluxo-admin/modulos-view.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/view-model/modulo-conta-viewmodel.dart';
import 'package:z_components/view-model/modulo-viewmodel.dart';

import '../z-item-tile-modulo-gestao.dart';

class Modulos extends StatefulWidget {
  ThemeData themeData;

  Modulos({this.themeData});

  @override
  _ModulosState createState() => _ModulosState();
}

class _ModulosState extends State<Modulos> {
  ModulosView _view;

  @override
  void initState() {
    _view = ModulosView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconeVoltar(context: context,),
        title: new Text("MÓDULOS"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new Column(
      children: [
        new ZSearchBar(
          key: _view.keySearchBar,
          camposFiltro: [],
          filtroPrincipal: new FiltroCampo(key: "Modulo.Nome", value: "nome"),
          onFilter: (filters) async {
            SearchOptions searchOptions = new SearchOptions();
            if (filters[0].value != "") {
              searchOptions.filters = filters;
            }
            OrderByExpression order = new OrderByExpression();
            order.propertyName = "Modulo.Nome";
            order.orientation = "ASC";
            searchOptions.orders = [order];
            await _view.buscarListaModulos(searchOptions);
          },
        ),
        _listarModulos(),
      ],
    );
  }

  Widget _listarModulos() {
    return new Expanded(
      child: ListView.builder(
        itemCount: _view.listaModulos.length,
        padding: EdgeInsets.only(top: 20.0),
        controller: _view.scrollController,
        shrinkWrap: true,
        itemBuilder: (builder, index) =>
            _montarCardModulo(_view.listaModulos[index]),
      ),
    );
  }

  Widget _montarCardModulo(ModuloContaViewModel moduloContaViewModel) {
    print(_view.listaModulos);
    print(moduloContaViewModel.toMap());
    return new Container(
      child: new ZItemTileModuloGestao(
        nomeModulo: moduloContaViewModel.modulo.nome,
        status: moduloContaViewModel.status,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListagemAplicativos(
                        moduloContaViewModel: moduloContaViewModel,
                      )));
        },
      ),
    );
  }
}

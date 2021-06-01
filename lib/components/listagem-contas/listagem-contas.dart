import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:z_components/z-item-tile-conta.dart';

import 'listagem-contas-view.dart';

class ListagemContas extends StatefulWidget {
  ThemeData themeData;

  ListagemContas({this.themeData});

  @override
  _ListagemContasState createState() => _ListagemContasState();
}

class _ListagemContasState extends State<ListagemContas> {
  ListagemContasView _view;

  @override
  void initState() {
    _view = ListagemContasView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("CONTAS"),
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
          filtroPrincipal:
              new FiltroCampo(key: "NomeUsuario", value: "nome Usuario"),
          onFilter: (filters) async {
            SearchOptions searchOptions = new SearchOptions();
            if (filters[0].value != "") {
              searchOptions.filters = filters;
            }
          },
        ),
        _listarUsuarios()
      ],
    );
  }

  Widget _listarUsuarios() {
    return new Expanded(
        child: new ListView.builder(
            padding: EdgeInsets.only(top: 20.0),
            controller: _view.scrollController,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (builder, index) => _montarCardUsuario()));
  }

  Widget _montarCardUsuario() {
    return new Container(
      child: new ZItemTileConta(
        dataVinculo: "01/06/2021",
        appsVinculados: "ZColaborador, ZPonto, ZCentral",
        ativo: true,
        nomeConta: "Zellar",
      ),
    );
  }
}

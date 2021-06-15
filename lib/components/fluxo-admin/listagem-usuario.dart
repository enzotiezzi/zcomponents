import 'package:brasil_fields/brasil_fields.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario-view.dart';
import 'package:z_components/components/modulo/detalhe-usuario.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/components/z-item-tile-usuario-adm.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/app-view-model.dart';
import 'package:z_components/view-model/modulo-conta-viewmodel.dart';

import '../z-item-tile-card-basico.dart';

class ListagemUsuarios extends StatefulWidget {
  AppViewModel appViewModel;
  ModuloContaViewModel moduloContaViewModel;

  ListagemUsuarios({this.appViewModel, this.moduloContaViewModel});

  @override
  _ListagemUsuariosState createState() => _ListagemUsuariosState();
}

class _ListagemUsuariosState extends State<ListagemUsuarios> {
  ListagemUsuariosView _view;

  @override
  void initState() {
    _view = ListagemUsuariosView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconeVoltar(context: context,),
        centerTitle: true,
        title: Text("LISTAGEM USUÁRIO"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new Column(
      children: [
        new Material(
          elevation: 4,
          child: new Container(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: new Text(
                    widget.appViewModel.nomeExibicao,
                    style: new TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: MainStyle.get(context).fontSizePadrao),
                  ),
                ),
              ],
            ),
          ),
        ),
        new ZSearchBar(
          key: _view.keySearchBar,
          camposFiltro: [],
          filtroPrincipal:
              new FiltroCampo(key: "Usuario.Nome", value: "nome Usuario"),
          onFilter: (filters) async {
            SearchOptions searchOptions = new SearchOptions();
            if (filters[0].value != "") {
              searchOptions.filters = filters;
            }
            OrderByExpression order = new OrderByExpression();
            order.propertyName = "Usuario.Nome";
            order.orientation = "ASC";
            searchOptions.orders = [order];
            await _view.buscarUsuario(searchOptions);
          },
        ),
        Expanded(
          child: _listaUsuarios(),
        )
      ],
    );
  }

  Widget _listaUsuarios() {
    if (_view.listaUsuarioPorApp != null) {
      return new ListView.builder(
          padding: EdgeInsets.only(top: 20.0),
          shrinkWrap: true,
          controller: _view.scrollController,
          itemCount: _view.listaUsuarioPorApp.length,
          itemBuilder: (builder, index) =>
              _montarCardUsuario(_view.listaUsuarioPorApp[index]));
    } else {
      return new Container();
    }
  }

  Widget _montarCardUsuario(AppUsuarioContaViewModel app) {
    return new Container(
      child: new ZItemTileUsuarioAdm(
        nomeUsuario: app.usuario.nome,
        status: app.status,
        telefone: app.usuario.telefone,
        email: app.usuario.email,
        appsVinculados: "",
        quantidadeApps: "",
        onTap: () async {
          var res = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetalheUsuario(
                    idModulo: widget.moduloContaViewModel.idModulo,
                    editarDados: false,
                    cliqueEditar: false,
                    appUsuarioContaViewModel: app),
              ));
          if (res != null) {
            _view.searchOptions = new SearchOptions();
            await _view.buscarUsuario(_view.searchOptions);
          }
        },
      ),
    );
  }
}

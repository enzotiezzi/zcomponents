import 'package:brasil_fields/brasil_fields.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario-view.dart';
import 'package:z_components/components/modulo/detalhe-usuario.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/components/z-item-tile-usuario-adm.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/app-view-model.dart';
import 'package:z_components/view-model/modulo-conta-viewmodel.dart';

import '../z-item-tile-modulo-gestao.dart';

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
          child: ConfigurableExpansionTile(
            initiallyExpanded: true,
            onExpansionChanged: (bool) {},
            borderColorStart: Color(0xffcccccc),
            borderColorEnd: Color(0xffcccccc),
            header: new Expanded(
              child: new Container(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
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
            animatedWidgetFollowingHeader: new Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: new Icon(
                Icons.arrow_drop_down,
                color: Color(0xffcccccc),
              ),
            ),
            children: [
              new ZItemTileModuloGestao(
                status: "Ativo",
                nomeModulo: widget.appViewModel.nomeExibicao,
                visibilidade: true,
              )
            ],
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
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetalheUsuario(
                    editarDados: true,
                    cliqueEditar: true,
                    appUsuarioContaViewModel: app),
              ));
        },
      ),
    );
  }

  String _listarAppsVinculados(List<AppUsuarioContaViewModel> lista) {
    String appsFormatados = "";
    if (lista != null && lista.length != 0) {
      for (int i = 0; i < lista.length; i++) {
        if (i == 0) {
          appsFormatados = "$appsFormatados- ${lista[i].app.nome}";
        } else {
          appsFormatados = "$appsFormatados, ${lista[i].app.nome}";
        }
      }
    } else {
      appsFormatados = "Sem apps vinculados";
    }
    return appsFormatados;
  }
}

import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/usuarios-view.dart';
import 'package:z_components/components/z-item-tile-usuario-adm.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/usuario-conta-viewmodel.dart';

import 'listagem-apps.dart';

class Usuarios extends StatefulWidget {
  ThemeData themeData;

  Usuarios({this.themeData});

  @override
  _UsuariosState createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
  UsuariosView _view;

  @override
  void initState() {
    _view = UsuariosView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("Usuários"),
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

            await _view.buscarListaUsuarios(searchOptions);
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
            itemCount: _view.listaUsuarios.length,
            itemBuilder: (builder, index) =>
                _montarCardUsuario(_view.listaUsuarios[index])));
  }

  Widget _montarCardUsuario(UsuarioContaViewModel usuario) {
    return new Container(
      child: new ZItemTileUsuarioAdm(
        nomeUsuario: usuario.nomeUsuario,
        email: usuario.email,
        quantidadeApps: usuario.appLista.length.toString(),
        status: usuario.status,
        appsVinculados: _listaAppsVinculados(usuario.appLista),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListagemApps(
                        listaApps: usuario.appLista,
                      )));
        },
      ),
    );
  }

  String _listaAppsVinculados(List<AppUsuarioContaViewModel> lista) {
    String appsFormatados = "";
    if (lista != null && lista.length != 0) {
      for (int i = 0; i < lista.length; i++) {
       if(i==0){appsFormatados = "$appsFormatados- ${lista[i].nomeApp}";}else{
         appsFormatados = "$appsFormatados, ${lista[i].nomeApp}";
       }
      }
    } else {
      appsFormatados = "Sem apps vinculados";
    }
    return appsFormatados;
  }
}
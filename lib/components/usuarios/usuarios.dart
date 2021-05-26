import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/usuarios/usuarios-view.dart';
import 'package:z_components/view-model/usuario-conta-viewmodel.dart';

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
          camposFiltro: [
            new FiltroCampo(key: "NomeNivel", value: "Nome nivel"),
          ],
          filtroPrincipal:
              new FiltroCampo(key: "NomeNivel", value: "Nome nivel"),
          onFilter: (filters) async {
            SearchOptions searchOptions = new SearchOptions();
            searchOptions.filters = filters;

            await _view.buscarListaUsuarios(searchOptions);

            searchOptions.pagination.pageNumber++;

            _view.searchOptions = searchOptions;
          },
        ),
        _listarUsuarios()
      ],
    );
  }

  Widget _listarUsuarios() {
    return new Expanded(
        child: new ListView.builder(
            controller: _view.scrollController,
            shrinkWrap: true,
            itemCount: _view.listaUsuarios.length,
            itemBuilder: (builder, index) =>
                _montarCardUsuario(_view.listaUsuarios[index])));
  }

  Widget _montarCardUsuario(UsuarioContaViewModel usuario) {
    return new Container(child: new Text(usuario.nomeUsuario));
  }
}

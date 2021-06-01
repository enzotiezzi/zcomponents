import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario.dart';
import 'package:z_components/components/fluxo-admin/modulos-view.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';

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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("GESTÃO DE APLICATIVO"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }


  Widget _buildBody (){
    return new Column(
      children: [
        ZSearchBar(
          key: _view.keySearchBar,
          camposFiltro: [],
          filtroPrincipal:
          new FiltroCampo(key: "NomeModulo", value: "nome Modulo"),
          onFilter: (filters) async{
            SearchOptions searchOptions = new SearchOptions();
            if (filters[0].value != "") {
              searchOptions.filters = filters;
            }

            //await _view.buscarListaModulos(searchOptions);
          },
        ),
        _listarModulos(),
      ],
    );
  }
  
  Widget _listarModulos (){
    return new Container(
      child: ListView.builder(
        itemCount: _view.listaModulos.length,
        shrinkWrap: true,
        controller: _view.scrollController,
        itemBuilder: (builder,index)=>
        _montarCardModulo()
      ),
    );
  }

  Widget _montarCardModulo(){
    return new Container(
      child: new ZItemTileModuloAdm(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListagemUsuarios(

                  )));
        },
      ),
    );
  }
}

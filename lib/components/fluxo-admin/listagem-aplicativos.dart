import 'package:brasil_fields/brasil_fields.dart';
import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/listagem-aplicativos-view.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario-view.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario.dart';
import 'package:z_components/components/modulo/detalhe-aplicativo.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/components/z-item-tile-modulo-gestao.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/app-view-model.dart';
import 'package:z_components/view-model/modulo-conta-viewmodel.dart';

import '../z-item-tile-card-basico.dart';

class ListagemAplicativos extends StatefulWidget {
  ModuloContaViewModel? moduloContaViewModel;

  ListagemAplicativos({this.moduloContaViewModel});

  @override
  _ListagemAplicativosState createState() => _ListagemAplicativosState();
}

class _ListagemAplicativosState extends State<ListagemAplicativos> {
  late ListagemAplicativosView _view;

  @override
  void initState() {
    _view = ListagemAplicativosView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconeVoltar(context: context,),
        centerTitle: true,
        title: new Text("APLICATIVOS"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new Column(
      children: [
        new Material(
          elevation: 4,
          child: new ConfigurableExpansionTile(
            initiallyExpanded: false,
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
                        widget.moduloContaViewModel?.modulo?.nome != null
                            ? widget.moduloContaViewModel!.modulo!.nome! : "",
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
              child: new Icon(Icons.arrow_drop_down, color: Color(0xffE6E6E6)),
            ),
            childrenBody:
              new ZItemTileModuloGestao(
                visibilidade: true,
                nomeModulo: widget.moduloContaViewModel?.modulo?.nome,status:  widget.moduloContaViewModel?.status,
              )

          ),
        ),
        new ZSearchBar(
          key: _view.keySearchBar,
          camposFiltro: [],
          filtroPrincipal:
              new FiltroCampo(key: "NomeExibicao", value: "nome Exibição"),
          onFilter: (filters) async {
            SearchOptions searchOptions = new SearchOptions();
            if (filters[0].value != "") {
              searchOptions.filters = filters;
            }
            OrderByExpression order = new OrderByExpression();
            order.propertyName = "NomeExibicao";
            order.orientation = "ASC";
            searchOptions.orders = [order];
            await _view.buscarAplicativos(searchOptions);
          },
        ),
        new Expanded(
          child: _listarAplicativos(),
        )
      ],
    );
  }

  Widget _listarAplicativos() {
    return new ListView.builder(
      padding: EdgeInsets.only(top: 20.0),
      shrinkWrap: true,
      controller: _view.scrollController,
      itemCount: _view.listaModulos.length,
      itemBuilder: (context, index) =>
          _montarCardAplicativo(_view.listaModulos[index]),
    );
  }

  Widget _montarCardAplicativo(AppViewModel appViewModel) {
    print(appViewModel.nome);
    return Container(
        child: new ZItemTileCardBasico(
      nome: appViewModel.nomeExibicao,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetalheAplicativo(
                      appViewModel: appViewModel,
                      contaViewModel: widget.moduloContaViewModel,
                    )));
      },
    ));
  }
}

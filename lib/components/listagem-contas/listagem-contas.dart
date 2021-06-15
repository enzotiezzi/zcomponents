import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/view-model/conta-v2-viewmodel.dart';
import 'package:z_components/z-item-tile-conta.dart';
import 'detalhe-conta.dart';
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
              new FiltroCampo(key: "Conta.Nome", value: "nome conta"),
          onFilter: (filters) async {
            SearchOptions searchOptions = new SearchOptions();
            if (filters[0].value != "") {
              searchOptions.filters = filters;
            }
            OrderByExpression order = new OrderByExpression();
            order.propertyName = "Conta.Nome";
            order.orientation = "ASC";
            searchOptions.orders = [order];
            await _view.buscarListaContas(searchOptions);
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
            itemCount: _view.listaContas.length,
            itemBuilder: (builder, index) =>
                _montarCardUsuario(_view.listaContas[index])));
  }

  Widget _montarCardUsuario(ContaV2ViewModel item) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetalheConta(
                      themeData: Theme.of(context),
                      contaV2ViewModel: item,
                    )));
      },
      child: new ZItemTileConta(
        visibilidade: false,
        dataVinculo: (item.dataVinculo != null)
            ? UtilData.obterDataDDMMAAAA(DateTime.parse(item.dataVinculo))
            : "Nunca",
        appsVinculados: _view.listarAppsVinculados(item.appLista),
        ativo: item.contaLogada,
        nomeConta: item.conta.nome ?? "",
        tamanhoLista: item.appLista.length,
      ),
    );
  }
}

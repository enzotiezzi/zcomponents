import 'dart:typed_data';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/conta-v2-viewmodel.dart';
import 'package:z_components/z-item-tile-conta.dart';
import 'detalhe-conta.dart';
import 'listagem-contas-view.dart';

class ListagemContas extends StatefulWidget {
  ThemeData? themeData;
  String? token;
  Function(ContaV2ViewModel)? onAccountChange;

  ListagemContas(
      {this.themeData, this.token, this.onAccountChange, GlobalKey? key})
      : super(key: key);

  @override
  ListagemContasState createState() => ListagemContasState();
}

class ListagemContasState extends State<ListagemContas> {
  late ListagemContasView _view;

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
        backgroundColor: widget.themeData!.primaryColor,
        leading: IconeVoltar(
          context: context,
        ),
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
                      themeData: widget.themeData,
                      contaV2ViewModel: item,
                      token: widget.token,
                      onAccountChange: widget.onAccountChange,
                    )));
      },
      child: new ZItemTileConta(
        imagemPerfil: _montarImagem(item.conta!.logo!),
        visibilidade: false,
        dataVinculo: (item.dataVinculo != null)
            ? UtilData.obterDataDDMMAAAA(DateTime.parse(item.dataVinculo!))
            : "Nunca",
        appsVinculados: _view.listarAppsVinculados(item.appLista),
        ativo: item.contaLogada,
        nomeConta: item.conta?.nome ?? "",
        tamanhoLista: item.appLista!.length,
      ),
    );
  }

  Widget _montarImagem(Uint8List logo) {
    if (logo != null) {
      return new Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(6.0), topLeft: Radius.circular(6.0)),
          image: new DecorationImage(
            image: MemoryImage(logo),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else
      return new Container();
  }

  void updateToken(String token, ThemeData theme) {
    if (mounted) {
      widget.token = token;
      widget.themeData = theme;
    }

    _view.initView();
  }
}

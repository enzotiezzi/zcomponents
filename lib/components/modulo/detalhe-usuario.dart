import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/filtro-campo.dart';
import 'package:z_components/components/modulo/detalhe-modulo.dart';
import 'package:z_components/components/modulo/detalhe-usuario-view.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/utils/svg.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';

import '../z-header.dart';
import '../z-item-tile-usuario-adm.dart';

class DetalheUsuario extends StatefulWidget {
  final bool editarDados;
  AppUsuarioContaViewModel appUsuarioContaViewModel;
  bool cliqueEditar;
  String idModulo;

  DetalheUsuario(
      {this.editarDados,
      this.appUsuarioContaViewModel,
      this.cliqueEditar,
      this.idModulo});

  @override
  _DetalheUsuarioState createState() => _DetalheUsuarioState();
}

class _DetalheUsuarioState extends State<DetalheUsuario> {
  DetalheUsuarioView _view;

  @override
  void initState() {
    _view = DetalheUsuarioView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconeVoltar(context: context,),
        actions: [
          PopupMenuButton<String>(
            icon: SvgPicture.asset(
              SvgUtils.ASSETMORE,
              semanticsLabel: "more.svg",
              placeholderBuilder: (context) => Icon(Icons.error),
            ),
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return _view.itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(item), _definirIcone(item)],
                  ),
                );
              }).toList();
            },
          )
        ],
        centerTitle: true,
        title: Text(
          "USUÁRIO",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
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
              initiallyExpanded: true,
              onExpansionChanged: (bool) {
                setState(() {});
              },
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
                          widget.appUsuarioContaViewModel.usuario.nome,
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
                child:
                    new Icon(Icons.arrow_drop_down, color: Color(0xffE6E6E6)),
              ),
              children: [
                new Divider(
                  height: 1.0,
                ),
                new Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: new ZItemTileUsuarioAdm(
                    visibilidade: true,
                    nomeUsuario: widget.appUsuarioContaViewModel.usuario.nome,
                    email: widget.appUsuarioContaViewModel.usuario.email,
                    quantidadeApps: "",
                    status: widget.appUsuarioContaViewModel.status,
                    telefone: widget.appUsuarioContaViewModel.usuario.telefone,
                    appsVinculados: "",
                  ),
                )
              ],
            )),
        new Expanded(child: _buildCampos()),
        exibirBotaoConfirmar()
      ],
    );
  }

  Widget _montarCampoPerfil() {
    if (widget.editarDados) {
      return ZCollection(
        key: _view.keyPerfil,
        filtroPrincipal: new FiltroCampo(key: "Nome", value: "Nome"),
        titulo: "Perfil",
        lista: _view.listaPerfis,
        themeData: Theme.of(context),
        valorPadrao: _view.perfilController.text,
        onChange: (value) {
          if (value != null) {
            widget.appUsuarioContaViewModel.perfil.nome = value.titulo;
            widget.appUsuarioContaViewModel.perfil.idApp =
                value.chaveSecundaria;
            widget.appUsuarioContaViewModel.perfil.idPerfil = value.chave;
            widget.appUsuarioContaViewModel.idPerfil = value.chave;
            setState(() {
              _view.alterouPerfil = true;
            });
          }
        },
        onFilter: (filter) async {
          SearchOptions searchOptions = new SearchOptions();
          OrderByExpression order = new OrderByExpression();
          order.propertyName = "Nome";
          order.orientation = "ASC";
          searchOptions.orders = [order];
          if (filter[0].value.isNotEmpty) {
            searchOptions.filters = filter;
          }
          var lista = await _view.buscarPerfis(searchOptions);
          setState(() {
            _view.keyPerfil.currentState.atualizarLista(lista);
          });
        },
        onScroll: (filter, listaAnterior) async {
          if (_view.paginationMetaData.hasNext) {
            SearchOptions searchOptions = new SearchOptions();
            OrderByExpression order = new OrderByExpression();
            order.propertyName = "Nome";
            order.orientation = "ASC";
            searchOptions.orders = [order];
            if (filter[0].value.isNotEmpty) {
              searchOptions.filters = filter;
            }
            searchOptions.pagination.pageNumber =
                _view.paginationMetaData.currentPage++;
            var lista = await _view.buscarPerfis(searchOptions);
            lista = listaAnterior + lista;
            setState(() {
              _view.keyPerfil.currentState.atualizarLista(lista);
            });
          }
        },
      );
    } else
      return ZInputGeneric(
        themeData: Theme.of(context),
        titulo: "Perfil",
        inputPadraoFocus: _view.perfilFocus,
        controllerInputPadrao: _view.perfilController,
        tipoTeclado: TextInputType.text,
        proximoFocus: _view.emailFocus,
        hintText: _view.hintNomePerfil,
        enabled: false,
      );
  }

  Widget _buildCampos() {
    return new ListView(
      shrinkWrap: true,
      children: [
        _montarCampoPerfil(),
        new Divider(
          height: 1.0,
        ),
        ZInputGeneric(
          themeData: Theme.of(context),
          titulo: "Nome",
          inputPadraoFocus: _view.nomeFocus,
          hintText: _view.hintStatus,
          controllerInputPadrao: _view.nomeController,
          enabled: false,
        ),
        new Divider(
          height: 1.0,
        ),
        new ZInputGeneric(
          titulo: "Email",
          themeData: Theme.of(context),
          inputPadraoFocus: _view.emailFocus,
          enabled: false,
          controllerInputPadrao: _view.emailController,
        ),
        new Divider(
          height: 1.0,
        ),
        ZInputGeneric(
            themeData: Theme.of(context),
            enabled: false,
            titulo: "Telefone",
            inputPadraoFocus: _view.telefoneFocus,
            hintText: _view.hintDataVinculo,
            controllerInputPadrao: _view.telefoneController),
      ],
    );
  }

  Widget exibirBotaoConfirmar() {
    if (widget.cliqueEditar == true) {
      return Material(
        elevation: 4,
        child: new Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height / 8,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new RaisedButton(
                onPressed: _view.editarOnPressed(),
                disabledColor: Colors.grey,
                child: new Container(
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new Container(
                        padding: const EdgeInsets.only(right: 40, left: 40),
                        child: Text(
                          "CONFIRMAR",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                color: Theme.of(context).accentColor,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  _escolhaMenuItem(String itemEscolhido) async {
    if (itemEscolhido.contains("Editar")) {
      var res = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalheUsuario(
              editarDados: true,
              cliqueEditar: true,
              appUsuarioContaViewModel: widget.appUsuarioContaViewModel,
              idModulo: widget.idModulo,
            ),
          ));
      if (res != null) {
        widget.appUsuarioContaViewModel = res;
        _view.preencherDados();
        setState(() {});
      }
    } else {
      _view.showDialogAlterarAcesso();
    }
  }

  Widget _definirIcone(String item) {
    if (item.contains("Editar")) {
      return Icon(
        Icons.edit,
        color: Theme.of(context).primaryColor,
      );
    } else {
      if (widget.appUsuarioContaViewModel.status == "Ativo") {
        return Icon(
          Icons.block_flipped,
          color: Colors.red,
        );
      } else {
        return Icon(
          Icons.check_circle,
          color: Theme.of(context).primaryColor,
        );
      }
    }
  }
}

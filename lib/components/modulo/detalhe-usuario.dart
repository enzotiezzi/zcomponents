import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/modulo/detalhe-usuario-view.dart';
import 'package:z_components/components/z-inputs/z-input-data-expiracao.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';

import '../z-header.dart';
import '../z-item-tile-usuario-adm.dart';

class DetalheUsuario extends StatefulWidget {
  final bool editarDados;
  AppUsuarioContaViewModel appUsuarioContaViewModel;
  bool cliqueEditar;

  DetalheUsuario(
      {this.editarDados, this.appUsuarioContaViewModel, this.cliqueEditar});

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
        actions: [_montarBotaoEditar()],
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
        //exibirBotaoConfirmar()
      ],
    );
  }

  Widget _buildCampos() {
    return new ListView(
      shrinkWrap: true,
      children: [
        ZInputGeneric(
          themeData: Theme.of(context),
          titulo: "Perfil",
          inputPadraoFocus: _view.perfilFocus,
          controllerInputPadrao: _view.perfilController,
          tipoTeclado: TextInputType.text,
          proximoFocus: _view.dataExpiracaoFocus,
          hintText: _view.hintNomePerfil,
          enabled: retornarEnabled(widget.editarDados),
        ),
        new Divider(
          height: 1.0,
        ),
        ZInputGeneric(
          themeData: Theme.of(context),
          titulo: "Status",
          inputPadraoFocus: _view.statusFocus,
          hintText: _view.hintStatus,
          controllerInputPadrao: _view.statusController,
          enabled: false,
        ),
        new Divider(
          height: 1.0,
        ),
        new ZInputDataExpiracao(
          themeData: Theme.of(context),
          dataFocus: _view.dataExpiracaoFocus,
          enabled: retornarEnabled(widget.editarDados),
          controllerData: _view.dataExpiracaoController,
          validacao: (validate) {
            if (validate) {
              //widget.appUsuarioContaViewModel.dataExpiracao = _view.dataVinculoController.text;
              _view.preencheuDataExpiracao = true;
              _view.validarCampos();
            }
          },
        ),
        new Divider(
          height: 1.0,
        ),
        ZInputGeneric(
            themeData: Theme.of(context),
            enabled: false,
            titulo: "Data de vinculo",
            inputPadraoFocus: _view.dataVinculoFocus,
            hintText: _view.hintDataVinculo,
            controllerInputPadrao: _view.dataVinculoController),
        //  exibirBotaoModificar()
      ],
    );
  }

  bool retornarEnabled(bool editar) {
    print(editar);
    if (editar == true) {
      return true;
    } else {
      return false;
    }
  }

  Widget _montarBotaoEditar() {
      return new GestureDetector(
        child: new Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.more_vert,
            size: 26,
            color: Theme.of(context).accentColor,
          ),
        ),
        onTap: () {},
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
}

import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';

import 'listagem-apps-view.dart';

class ListagemApps extends StatefulWidget {
  List<AppUsuarioContaViewModel> listaApps;

  ListagemApps({this.listaApps});

  @override
  _ListagemAppsState createState() => _ListagemAppsState();
}

class _ListagemAppsState extends State<ListagemApps> {
  ListagemAppsView _view;

  @override
  void initState() {
    _view = ListagemAppsView(this);
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
    return new ListView.builder(
        padding: EdgeInsets.only(top: 20.0),
        shrinkWrap: true,
        itemCount: widget.listaApps.length,
        itemBuilder: (builder, index) =>
            _montarCardUsuario(widget.listaApps[index]));
  }

  Widget _montarCardUsuario(AppUsuarioContaViewModel app) {
    return new Container(
      child: new ZItemTileModuloAdm(
        dataExpiracao: app.dataExpiracao ?? "nunca",
        dataVinculo: app.dataVinculo,
        nomeModulo: app.nomeApp,
        perfilAcesso: app.nomePerfil ?? "Não contém perfil",
        statusVinculo: app.status,
      ),
    );
  }
}

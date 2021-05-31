import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile-modulo-adm.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/usuario-conta-viewmodel.dart';

import '../z-item-tile-usuario-adm.dart';
import 'listagem-apps-view.dart';

class ListagemApps extends StatefulWidget {
  List<AppUsuarioContaViewModel> listaApps;
  UsuarioContaViewModel usuario;

  ListagemApps({this.listaApps, this.usuario});

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
    return new Column(
      children: [
        new Material(
            elevation: 4,
            child: new Container(margin: EdgeInsets.only(top: 10.0),
              child: new ZItemTileUsuarioAdm(
                nomeUsuario: widget.usuario.nomeUsuario,
                email: widget.usuario.email,
                quantidadeApps: widget.usuario.appLista.length.toString(),
                status: widget.usuario.status,
                appsVinculados:
                    _view.listarAppsVinculados(widget.usuario.appLista),
              ),
            )),
        new Expanded(
          child: _ListarModulos(),
        )
      ],
    );
  }

  Widget _ListarModulos() {
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
        dataExpiracao: (app.dataExpiracao != null)
            ? UtilData.obterDataDDMMAAAA(DateTime.parse(app.dataExpiracao))
            : "nunca",
        dataVinculo: (app.dataVinculo != null)
            ? UtilData.obterDataDDMMAAAA(DateTime.parse(app.dataVinculo))
            : "nunca",
        nomeModulo: app.nomeApp,
        perfilAcesso: app.nomePerfil ?? "Não contém perfil",
        statusVinculo: app.status,
      ),
    );
  }
}

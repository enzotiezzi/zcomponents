import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/fluxo-admin/listagem-usuario.dart';
import 'package:z_components/components/modulo/detalhe-aplicativo-view.dart';
import 'package:z_components/components/z-aba/z-aba-viewmodel.dart';
import 'package:z_components/components/z-aba/z-aba.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/app-view-model.dart';
import 'package:z_components/view-model/modulo-conta-viewmodel.dart';

class DetalheAplicativo extends StatefulWidget {
  AppViewModel appViewModel;
  ModuloContaViewModel contaViewModel;

  DetalheAplicativo({this.appViewModel, this.contaViewModel});

  @override
  _DetalheAplicativoState createState() => _DetalheAplicativoState();
}

class _DetalheAplicativoState extends State<DetalheAplicativo> {
  DetalheAplicativoView _view;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _view = DetalheAplicativoView(this);
    _view.initView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("APLICATIVO"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new Column(
      children: [
        new Material(
          elevation: 4,
          child: new Container(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: new Text(
                      widget.appViewModel.nomeExibicao,
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
        new ZAba(
          zAbaViewModel: [
            ZAbaViewModel(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListagemUsuarios(
                                appViewModel: widget.appViewModel,
                                moduloContaViewModel: widget.contaViewModel,
                              )));
                },
                titulo: "Usuários",
                icon: Icon(Icons.group)),
            ZAbaViewModel(
                onTap: () {}, titulo: "Parâmetros", icon: Icon(Icons.settings))
          ],
        ),
        new Expanded(child: _buildCampos())
      ],
    );
  }

  Widget _buildCampos() {
    return new ListView(
      shrinkWrap: true,
      children: [
        new ZInputGeneric(
          themeData: Theme.of(context),
          titulo: "Nome",
          enabled: false,
          controllerInputPadrao: _view.nomeController,
          inputPadraoFocus: _view.moduloFocus,
        ),
        new Divider(
          height: 1,
        ),
        new ZInputGeneric(
          themeData: Theme.of(context),
          titulo: "Versão",
          enabled: false,
          controllerInputPadrao: _view.versaoController,
          inputPadraoFocus: _view.versaoFocus,
        ),
        new Divider(
          height: 1,
        ),
        new ZInputGeneric(
          themeData: Theme.of(context),
          titulo: "Data da Versão",
          enabled: false,
          controllerInputPadrao: _view.dataVersaoController,
          inputPadraoFocus: _view.dataVersaoFocus,
        ),
        new Divider(
          height: 1,
        ),
        new ZInputGeneric(
          themeData: Theme.of(context),
          titulo: "Módulo",
          enabled: false,
          controllerInputPadrao: _view.moduloController,
          inputPadraoFocus: _view.moduloFocus,
        ),
        new Divider(
          height: 1,
        ),
      ],
    );
  }
}

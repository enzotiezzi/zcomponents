import 'package:brasil_fields/brasil_fields.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/modulo/detalhe-modulo-view.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-inputs/z-input-data-de-nascimento.dart';
import 'package:z_components/components/z-inputs/z-input-data-expiracao.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/usuario-conta-viewmodel.dart';

import '../z-item-tile-modulo-adm.dart';
import '../z-item-tile-usuario-adm.dart';

class DetalheModulo extends StatefulWidget {

  final bool editarDados;
  AppUsuarioContaViewModel appUsuarioContaViewModel;
  bool cliqueEditar;
  UsuarioContaViewModel usuario;

  DetalheModulo({this.editarDados,this.appUsuarioContaViewModel,this.cliqueEditar,this.usuario});

  @override
  _DetalheModuloState createState() => _DetalheModuloState();
}

class _DetalheModuloState extends State<DetalheModulo> {

  DetalheModuloView _view;

  @override
  void initState() {
    _view = DetalheModuloView(this);
    _view.initView();
    super.initState();
    print(widget.appUsuarioContaViewModel.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          //_montarBotaoEditar()
        ],
        centerTitle: true,
        title: Text(
          "APLICATIVO",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color:Colors.white
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _montarBotaoEditar() {
    if (retornarEnabled(widget.editarDados)) {
      return new Container();
    } else {
      return new GestureDetector(
        child: new Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.edit,
            size: 26,
            color: Theme.of(context).accentColor,
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetalheModulo(
                    editarDados: true,
                    cliqueEditar: true,
                    appUsuarioContaViewModel: widget.appUsuarioContaViewModel
                    ),
                  ));
        },
      );
    }
  }

  Widget _buildBody(){
    return new Column(
      children: [
        Material(
          elevation: 4,
          child: new ConfigurableExpansionTile(
            initiallyExpanded: false,
            onExpansionChanged: (bool){},
            borderColorStart: Color(0xffcccccc),
            borderColorEnd: Color(0xffcccccc),
            header: new Expanded(
              child: new Container(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      padding: const EdgeInsets.only(top: 8,bottom: 8),
                      child: new Text(
                        widget.appUsuarioContaViewModel.app.nomeExibicao,
                        style: new TextStyle(
                            color:Colors.black,
                            fontWeight:FontWeight.w500,
                            fontSize: MainStyle.get(context).fontSizePadrao
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            animatedWidgetFollowingHeader: new Container(
              padding: const EdgeInsets.only(top: 8,bottom: 8),
              child: new Icon(Icons.arrow_drop_down,color: Color(0xffcccccc),),
            ),
            children: [
              new ZItemTileUsuarioAdm(
                visibilidade: true,
                nomeUsuario: widget.usuario.usuario.nome,
                email: widget.usuario.usuario.email,
                quantidadeApps: widget.usuario.appLista.length.toString(),
                status: widget.usuario.status,
                telefone: widget.usuario.usuario.telefone,
                appsVinculados:
                _view.listarAppsVinculados(widget.usuario.appLista),
              ),
            ],
          ),
        ),
        new Expanded(child: _buildCampos()),
        exibirBotaoConfirmar()
      ],
    );
  }

  bool retornarEnabled(bool editar){
    print(editar);
    if(editar==true){
        return true;
    }else {
      return false;
    }
  }

  Widget exibirBotaoConfirmar(){
    if(widget.cliqueEditar==true){
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
                        padding: const EdgeInsets.only(right: 40,left: 40),
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
    }else{
      return Container();
    }
  }


  Widget _buildCampos(){
    return new ListView(
      shrinkWrap: true,
      children: [

        Container(
          margin: EdgeInsets.only(top: 10),
          child: new ZInputGeneric(
            themeData: Theme.of(context),
            titulo: "Perfil",
            inputPadraoFocus: _view.perfilFocus,
            controllerInputPadrao: _view.perfilController,
            tipoTeclado: TextInputType.text,
            proximoFocus: _view.dataExpiracaoFocus,
            hintText: _view.hintNomePerfil,
            enabled: retornarEnabled(widget.editarDados),
          ),
        ),
        new Divider(height: 1.0,),
        new ZInputGeneric(
          themeData: Theme.of(context),
          titulo: "Status",
          inputPadraoFocus: _view.statusFocus,
          hintText: _view.hintStatus,
          controllerInputPadrao: _view.statusController,
          enabled: false,
        ),
        new Divider(height: 1.0,),
        new  ZInputDataExpiracao(
          themeData: Theme.of(context),
          dataFocus: _view.dataExpiracaoFocus,
          enabled: retornarEnabled(widget.editarDados),
          controllerData: _view.dataExpiracaoController,
          validacao: (validate) {
            if(validate){
              //widget.appUsuarioContaViewModel.dataExpiracao = _view.dataVinculoController.text;
              _view.preencheuDataExpiracao = true;
              _view.validarCampos();
            }
          },
        ),
        new Divider(height: 1.0,),
        new ZInputGeneric(
            themeData: Theme.of(context),
            enabled: false,
            titulo: "Data de vinculo",
            inputPadraoFocus: _view.dataVinculoFocus,
            hintText: _view.hintDataVinculo,
            controllerInputPadrao: _view.dataVinculoController
        ),
      ],
    );
  }
}

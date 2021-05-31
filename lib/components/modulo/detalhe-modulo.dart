import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/modulo/detalhe-modulo-view.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-inputs/z-input-data-de-nascimento.dart';
import 'package:z_components/components/z-inputs/z-input-data-expiracao.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';

class DetalheModulo extends StatefulWidget {

  final bool editarDados;
  AppUsuarioContaViewModel appUsuarioContaViewModel;
  bool cliqueEditar;

  DetalheModulo({this.editarDados,this.appUsuarioContaViewModel,this.cliqueEditar});

  @override
  _DetalheModuloState createState() => _DetalheModuloState();
}

class _DetalheModuloState extends State<DetalheModulo> {

  DetalheModuloView _view;
  //AppUsuarioContaViewModel appUsuarioContaViewModel;

  @override
  void initState() {
    _view = DetalheModuloView(this);
    _view.initView();
    //appUsuarioContaViewModel = widget.AppUsuarioContaViewModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _montarBotaoEditar()
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
                    appUsuarioContaViewModel: AppUsuarioContaViewModel(
                        nomeApp: widget.appUsuarioContaViewModel.nomeApp,
                        dataExpiracao: widget.appUsuarioContaViewModel.dataExpiracao,
                        dataVinculo: widget.appUsuarioContaViewModel.dataVinculo,
                        descricaoPerfil: widget.appUsuarioContaViewModel.nomePerfil,
                        status: widget.appUsuarioContaViewModel.status ?? "Não contém perfil"
                    ),
                  )));
        },
      );
    }
  }

  Widget _buildBody(){
    return new Column(
      children: [
        new ZHeader(
          titulo: _view.titulo,
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

  Widget exibirBotaoRevogar(){
    if(widget.cliqueEditar==true){
      return Material(
        //elevation: 4,
        child: new Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(top: 6,bottom: 6),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new RaisedButton(
                onPressed: (){},
                child: new Container(
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new Container(
                        padding: const EdgeInsets.only(right: 40,left: 40),
                        child: Text(
                          "REVOGAR ACESSO",
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
        new Divider(height: 1.0,),
        ZInputGeneric(
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
        ZInputGeneric(
            themeData: Theme.of(context),
            enabled: false,
            titulo: "Data de vinculo",
            inputPadraoFocus: _view.dataVinculoFocus,
            hintText: _view.hintDataVinculo,
            controllerInputPadrao: _view.dataVinculoController
        ),
        exibirBotaoRevogar()
      ],
    );
  }
}

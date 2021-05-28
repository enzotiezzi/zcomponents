import 'package:flutter/material.dart';
import 'package:z_components/components/modulo/detalhe-modulo-view.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-inputs/z-input-data-de-nascimento.dart';
import 'package:z_components/components/z-inputs/z-input-data-expiracao.dart';
import 'package:z_components/components/z-inputs/z-input-generic.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';

class DetalheModulo extends StatefulWidget {

  final bool editarDados;
  final AppUsuarioContaViewModel;

  DetalheModulo({this.editarDados,this.AppUsuarioContaViewModel});

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
          "Módulo",
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
    if (widget.editarDados) {
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
                  )));
        },
      );
    }
  }

  Widget _buildBody(){
    return new Column(
      children: [
        new Expanded(child: _buildCampos()),
        _view.exibirBotao()
      ],
    );
  }

  bool retornarEnabled(bool editar){
    print(editar);
    if(editar==true){
      return true;
    }else{
      return false;
    }
  }

  Widget _buildCampos(){
    return new ListView(
      shrinkWrap: true,
      children: [
        ZInputGeneric(
            themeData: Theme.of(context),
            controllerInputPadrao: _view.moduloController,
            inputPadraoFocus: _view.moduloFocus,
            enabled: false,
            titulo: "Módulo",
        ),
        new Divider(height: 1.0,),
        ZInputGeneric(
            themeData: Theme.of(context),
            titulo: "Perfil",
            inputPadraoFocus: _view.perfilFocus,
            controllerInputPadrao: _view.perfilController,
            tipoTeclado: TextInputType.text,
            proximoFocus: _view.dataVinculoFocus,
            enabled: retornarEnabled(widget.editarDados),
        ),
        new Divider(height: 1.0,),
        ZInputGeneric(
            themeData: Theme.of(context),
            titulo: "Status",
            inputPadraoFocus: _view.statusFocus,
            controllerInputPadrao: _view.statusController,
            enabled: false,

        ),
        new Divider(height: 1.0,),
        new  ZInputDataExpiracao(
          themeData: Theme.of(context),
          dataFocus: _view.dataExpiracaoFocus,
          enabled: retornarEnabled(widget.editarDados),
          controllerData: _view.dataExpiracaoController,
          onChange: (p){},
          validacao: (bool) {},
        ),
        new Divider(height: 1.0,),
        ZInputGeneric(
            themeData: Theme.of(context),
            enabled: false,
            titulo: "Data de vinculo",
            inputPadraoFocus: _view.dataVinculoFocus,
            controllerInputPadrao: _view.dataVinculoController
        ),
      ],
    );
  }
}

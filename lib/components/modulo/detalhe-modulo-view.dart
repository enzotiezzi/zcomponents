import 'package:flutter/material.dart';
import 'package:z_components/components/modulo/detalhe-modulo.dart';
import 'package:z_components/i-view.dart';


class DetalheModuloView extends IView<DetalheModulo>{
  DetalheModuloView(State<DetalheModulo> state) : super(state);

  @override
  Future<void> afterBuild() {
  }

  @override
  Future<void> initView() {

    if (state.widget.editarDados) {
      Future.delayed(Duration(seconds: 1), () {
        FocusScope.of(state.context).requestFocus(perfilFocus);
      });
    }
  }

  TextEditingController dataExpiracaoController = new TextEditingController();
  FocusNode dataExpiracaoFocus = new FocusNode();
  TextEditingController dataController = new TextEditingController();
  FocusNode dataFocus = new FocusNode();
  TextEditingController statusController = new TextEditingController(text: "Ativo");
  FocusNode statusFocus = new FocusNode();
  TextEditingController moduloController = new TextEditingController();
  FocusNode moduloFocus = new FocusNode();
  TextEditingController perfilController = new TextEditingController();
  FocusNode perfilFocus = new FocusNode();
  TextEditingController dataVinculoController = new TextEditingController();
  FocusNode dataVinculoFocus = new FocusNode();

  bool editarDados = false;




  Widget exibirBotao(){
    if(statusController.text=="Ativo"){
      return Material(
        elevation: 4,
        child: new Container(
          color: Colors.white,
          height: MediaQuery.of(state.context).size.height / 8,
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
                          "REVOGAR",
                          style: Theme.of(state.context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                color: Theme.of(state.context).accentColor,
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


}
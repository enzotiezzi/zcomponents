import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/modulo/detalhe-aplicativo.dart';
import 'package:z_components/i-view.dart';

class DetalheAplicativoView extends IView<DetalheAplicativo>{
    DetalheAplicativoView(State<DetalheAplicativo> state) : super(state);

    TextEditingController nomeController = new TextEditingController();
    FocusNode nomeFocus = new FocusNode();
    TextEditingController versaoController = new TextEditingController();
    FocusNode versaoFocus = new FocusNode();
    TextEditingController dataVersaoController = new TextEditingController();
    FocusNode dataVersaoFocus = new FocusNode();
    TextEditingController moduloController = new TextEditingController();
    FocusNode moduloFocus = new FocusNode();

    void _preencherDados(){
        nomeController.text = state.widget.appViewModel!.nomeExibicao!;
        versaoController.text = state.widget.appViewModel!.versao!;
        dataVersaoController.text = _validarDataVersao();
        moduloController.text = state.widget.contaViewModel!.modulo!.nome!;

    }

    String _validarDataVersao(){
        if(state.widget.appViewModel!.dataVersao != null){
            return UtilData.obterDataDDMMAAAA(DateTime.parse(state.widget.appViewModel!.dataVersao!));
        }else{
            return "Nunca";
        }
    }


    @override
    Future<void> afterBuild() {
        // TODO: implement afterBuild
        throw UnimplementedError();
    }

    @override
    Future<void> initView() {
        _preencherDados();
        throw UnimplementedError();
    }
}
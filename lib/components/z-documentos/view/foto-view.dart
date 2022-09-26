import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:z_components/components/z-documentos/presenter/foto.dart';
import 'package:z_components/i-view.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-injector/z-injector.dart';

class FotoView extends IView<Foto> {
  FotoView(State<Foto> state) : super(state);
  var retorno;
  bool carregou = false;
  var fotoOriginal;

  @override
  Future initView() async {
    imageClick();
  }

  Future imageClick() async {
    state.setState(() {});
  }

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  void selecionarItem(List<Uint8List> item) {
    Navigator.of(state.context).pop(item);
  }

  Future<void> verificarSeDesejaExcluir(bool desejaExcluirImagem) async {
    if (desejaExcluirImagem) {
      state.widget.fotos[state.widget.hero] = Uint8List(0);
      selecionarItem(state.widget.fotos);
    } else {
      selecionarItem(state.widget.fotos);
    }
  }
}

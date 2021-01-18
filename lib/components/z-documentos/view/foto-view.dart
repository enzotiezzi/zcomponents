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

  Future showAlertDialog() async {
    var buttons = new List<Widget>();

    buttons.add(new CupertinoDialogAction(
        child: new Text(
          "EXCLUIR",
          style: const TextStyle(color: Colors.blue),
        ),
        onPressed: () {
          Navigator.of(state.context).pop(true);
        }));

    buttons.add(new CupertinoDialogAction(
        child: new Text("CANCELAR"),
        onPressed: () {
          Navigator.of(state.context).pop();
        }));

    return showDialog(
        context: state.context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
            title: new Text("Atenção!"),
            content: new Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: new Text("Você deseja excluir esta imagem?"),
            ),
            actions: buttons));
  }

  void selecionarItem(List<Uint8List> item) {
    Navigator.of(state.context).pop(item);
  }

  Future<void> verificarSeDesejaExcluir() async {
    var res = await showAlertDialog();
    if (res != null) {
      state.widget.fotos.removeAt(state.widget.hero);
      selecionarItem(state.widget.fotos);
    } else {
      selecionarItem(state.widget.fotos);
    }
  }
}

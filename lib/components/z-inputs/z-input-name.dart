import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputName extends StatefulWidget {
  final Key key;
  FocusNode nomeFocus;
  var controllerNome = new TextEditingController();
  FocusNode proximoFocus;

  ZInputName({
    this.key,
    @required this.nomeFocus,
    @required this.controllerNome,
    this.proximoFocus,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZInputNameState();
}

class _ZInputNameState extends State<ZInputName> {
  DialogUtils _dialogUtils;
  String nome;
  int countNome = 1;
  bool valideNome;

  @override
  void initState() {
    _dialogUtils = new DialogUtils(context);
    super.initState();
    initNome();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.styleTextInput(
        context,
        "Nome:",
        TextInputType.text,
        () {
          FocusScope.of(context).requestFocus(widget.nomeFocus);
        },
        widget.nomeFocus,
        widget.controllerNome,
        widget.proximoFocus,
        (text) {
          nome = text;
          countNome = 0;
        },
        false);
  }

  void initNome() {
    widget.nomeFocus.addListener(() {
      if (!widget.nomeFocus.hasFocus && countNome == 0 && nome != "") {
        _valideNome();
      }
    });
  }

  void _valideNome() {
    if (nome == null) {
      valideNome = false;
      _dialogUtils.showAlertDialogNewAviso(
          "Nome Inválido!", "Por Favor insira o nome completo.");
    } else if (nome.split(' ').length < 2) {
      valideNome = false;
      _dialogUtils.showAlertDialogNewAviso(
          "Nome Inválido!", "Por Favor insira o nome completo.");
    } else {
      if (nome.split(' ')[1].length < 2) {
        valideNome = false;
        _dialogUtils.showAlertDialogNewAviso(
            "Nome Inválido!", "Por Favor insira o nome completo.");
      }else{
        valideNome = true;

      }
    }
  }
}

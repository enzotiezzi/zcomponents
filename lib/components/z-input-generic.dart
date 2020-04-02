import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputGeneric extends StatefulWidget {
  final Key key;
  String hintText;
  String textMask;
  String titulo;
  FocusNode inputPadraoFocus;
  var controllerInputPadrao = new TextEditingController();
  FocusNode proximoFocus;
  Function metodo;

  ZInputGeneric({
    this.key,
    @required this.hintText,
    @required this.titulo,
    @required this.textMask,
    @required this.metodo,
    @required this.inputPadraoFocus,
    @required this.controllerInputPadrao,
    this.proximoFocus,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ZInputGenericState();
}

class ZInputGenericState extends State<ZInputGeneric> {
  int countcpf = 1;
  DialogUtils _dialogUtils;
  String cpf;
  bool valideCpf;

  @override
  void initState() {
    _dialogUtils = new DialogUtils(context);
    initNome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.styleTextInput(
        context,
        "${widget.titulo}:",
        TextInputType.text,
        () {
          FocusScope.of(context).requestFocus(widget.inputPadraoFocus);
        },
        widget.inputPadraoFocus,
        widget.controllerInputPadrao,
        widget.proximoFocus,
        (text) {
          cpf = text;
          countcpf = 0;
          if (cpf.length == 14) {
            _fieldFocusChange(
                context, widget.inputPadraoFocus, widget.proximoFocus);
          }
        },
        true,
        textMask: "${widget.textMask}",
        hintText: "${widget.hintText}");
  }

  void initNome() {
    widget.inputPadraoFocus.addListener(() {
      if (!widget.inputPadraoFocus.hasFocus && countcpf == 0 && cpf != "") {
        widget.metodo();
      }
    });
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    if (nextFocus != null) {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}

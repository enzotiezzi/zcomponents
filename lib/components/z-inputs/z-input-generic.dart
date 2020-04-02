import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputGeneric extends StatefulWidget {
  final Key key;
  String hintText;
  String textMask;
  String titulo;
  bool comMascara;
  FocusNode inputPadraoFocus;
  ValueChanged<String> onChange;

  var controllerInputPadrao = new TextEditingController();
  FocusNode proximoFocus;
  Function metodo;

  ZInputGeneric({
    this.key,
    this.hintText,
    this.onChange,
    this.comMascara:false,
    @required this.titulo,
    this.textMask,
    this.metodo,
    @required this.inputPadraoFocus,
    @required this.controllerInputPadrao,
    this.proximoFocus,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ZInputGenericState();
}

class ZInputGenericState extends State<ZInputGeneric> {

  @override
  void initState() {
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
          if (widget.onChange != null) widget.onChange(text);
        },
        widget.comMascara,
        textMask: "${widget.textMask}",
        hintText: "${widget.hintText}");
  }

}

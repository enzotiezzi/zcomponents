import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputCNPJ extends StatefulWidget {

  final Key key;
  FocusNode cnpjFocus;
  var controllerCNPJ = new TextEditingController();
  FocusNode proximoFocus;

  ZInputCNPJ(
      {this.key,
        this.cnpjFocus,
        this.controllerCNPJ,
        this.proximoFocus,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ZInputCNPJState();
}

class ZInputCNPJState extends State<ZInputCNPJ> {

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
        "CNPJ:",
        TextInputType.number,
            () {
          FocusScope.of(context).requestFocus(widget.cnpjFocus);
        },
        widget.cnpjFocus,
        widget.controllerCNPJ,
        widget.proximoFocus,
            (text) {
          cpf = text;
          countcpf = 0;
          if (cpf.length == 18) {
            _fieldFocusChange(context, widget.cnpjFocus,
                widget.proximoFocus);
          }
        },true,
        textMask: "XX.XXX.XXX/XXXX-XX",
        hintText: "XX.XXX.XXX/XXXX-XX");
  }

  void initNome() {
    widget.cnpjFocus.addListener(() {
      if (!widget.cnpjFocus.hasFocus &&
          countcpf == 0 &&
          cpf != "") {
        _validarCNPJ();
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

  void _validarCNPJ() {}

}

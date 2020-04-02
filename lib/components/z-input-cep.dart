import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputCEP extends StatefulWidget {

  final Key key;
  FocusNode cepFocus;
  var controllerCep = new TextEditingController();
  FocusNode proximoFocus;

  ZInputCEP(
      {this.key,
        this.cepFocus,
        this.controllerCep,
        this.proximoFocus,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ZInputCEPState();
}

class ZInputCEPState extends State<ZInputCEP> {

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
        "CEP:",
        TextInputType.number,
            () {
          FocusScope.of(context).requestFocus(widget.cepFocus);
        },
        widget.cepFocus,
        widget.controllerCep,
        widget.proximoFocus,
            (text) {
          cpf = text;
          countcpf = 0;
          if (cpf.length == 14) {
            _fieldFocusChange(context, widget.cepFocus,
                widget.proximoFocus);
          }
        },true,
        textMask: "XXXXX-XXX",
        hintText: "XXXXX-XXX");
  }

  void initNome() {
    widget.cepFocus.addListener(() {
      if (!widget.cepFocus.hasFocus &&
          countcpf == 0 &&
          cpf != "") {
        _validarCEP();
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
  void _validarCEP() {

  }
}

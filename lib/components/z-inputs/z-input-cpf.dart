import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputCPF extends StatefulWidget {
  final Key key;
  FocusNode cpfFocus;
  var controllerCpf = new TextEditingController();
  FocusNode proximoFocus;
  ValueChanged<String> onChange;
  void Function(bool) validacao;
  bool enabled;
  final ThemeData themeData;
  final bool campoObrigatorio;

  ZInputCPF(
      {this.key,
      @required this.themeData,
      @required this.cpfFocus,
      @required this.controllerCpf,
      this.proximoFocus,
      this.onChange,
      this.validacao,
      this.enabled,
      this.campoObrigatorio=false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZInputCPFState();
}

class _ZInputCPFState extends State<ZInputCPF> {
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
        "CPF",
        TextInputType.number,
        () {
          FocusScope.of(context).requestFocus(widget.cpfFocus);
        },
        widget.cpfFocus,
        widget.controllerCpf,
        widget.proximoFocus,
        (text) {
          if (widget.onChange != null) widget.onChange(text);

          cpf = text;
          countcpf = 0;
          if (cpf.length == 14) {
            _fieldFocusChange(context, widget.cpfFocus, widget.proximoFocus);
          }
        },
        true,
        themeData: widget.themeData,
        campoObrigatorio: widget.campoObrigatorio,
        textMask: "###.###.###-##",
        hintText: "XXX.XXX.XXX-XX",enabled: widget.enabled);
  }

  void initNome() {
    widget.cpfFocus.addListener(() {
      if (!widget.cpfFocus.hasFocus && countcpf == 0 && cpf != "") {
        _validarCPF();
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

  void _validarCPF() {
    if (!CPFValidator.isValid(cpf)) {
      valideCpf = false;
      _dialogUtils.showAlertDialogNewAviso(
          "CPF Inválido!", "Por Favor insira um CPF válido.");
      widget.validacao(false);
    } else {
      valideCpf = true;
      widget.validacao(true);
    }
  }
}

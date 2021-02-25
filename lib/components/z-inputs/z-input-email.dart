import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputEmail extends StatefulWidget {
  final Key key;
  FocusNode emailFocus;
  var controllerEmail = new TextEditingController();
  FocusNode proximoFocus;
  String email;
  bool valideEmail;
  ValueChanged<String> onChange;
  void Function(bool) validacao;
  bool enabled;
  final bool campoObrigatorio;
  final ThemeData themeData;

  ZInputEmail(
      {this.key,
      this.onChange,
      @required this.themeData,
      @required this.emailFocus,
      @required this.controllerEmail,
      this.proximoFocus,
      this.validacao,
      this.enabled,
      this.campoObrigatorio = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZInputDataNascimentoState();
}

class _ZInputDataNascimentoState extends State<ZInputEmail> {
  int emailCount = 1;
  DialogUtils _dialogUtils;
  String data;

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
        "E-mail",
        TextInputType.emailAddress,
        () {
          FocusScope.of(context).requestFocus(widget.emailFocus);
        },
        widget.emailFocus,
        widget.controllerEmail,
        widget.proximoFocus,
        (text) {
          if (widget.onChange != null) widget.onChange(text);

          data = text;
          emailCount = 0;
        },
        false,
        themeData: widget.themeData,
        campoObrigatorio: widget.campoObrigatorio,
        hintText: "email@exemplo.com",
        enabled: widget.enabled);
  }

  void initNome() {
    widget.emailFocus.addListener(() {
      if (!widget.emailFocus.hasFocus && emailCount == 0 && data != "") {
        _validarEmail();
      }
    });
  }

  void _validarEmail() {
   if (!EmailValidator.validate(widget.email)) {
      widget.valideEmail = false;
      _dialogUtils.showAlertDialogNewAviso(
          "E-mail Inválido!", "Por Favor insira um E-mail válido.");
      widget.validacao(false);
    } else {
      widget.valideEmail = true;
      widget.validacao(true);
    }
  }
}

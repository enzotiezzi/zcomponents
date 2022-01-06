import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputCEP extends StatefulWidget {
  final Key key;
  FocusNode cepFocus;
  var controllerCep = new TextEditingController();
  FocusNode proximoFocus;
  ValueChanged<String> onChange;
  void Function(bool) validacao;
  bool enabled;
  final bool campoObrigatorio;
  final ThemeData themeData;

  ZInputCEP(
      {this.key,
      @required this.themeData,
      @required this.cepFocus,
      @required this.controllerCep,
      this.onChange,
      this.proximoFocus,
      this.validacao,
      this.enabled,
      this.campoObrigatorio=false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZInputCEPState();
}

class _ZInputCEPState extends State<ZInputCEP> {
  DialogUtils _dialogUtils;
  String cep = "";

  @override
  void initState() {
    _dialogUtils = new DialogUtils(context);
    initCep();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.styleTextInput(
        context,
        "CEP",
        TextInputType.number,
        () {
          FocusScope.of(context).requestFocus(widget.cepFocus);
        },
        widget.cepFocus,
        widget.controllerCep,
        widget.proximoFocus,
        (text) {
          if (widget.onChange != null) widget.onChange(text);

          cep = text;
          if (cep.length == 9) {
            _fieldFocusChange(context, widget.cepFocus, widget.proximoFocus);
          }
        },
        true,
        themeData: widget.themeData,
        campoObrigatorio: widget.campoObrigatorio,
        textMask: "#####-###",
        hintText: "00000-000",
        enabled: widget.enabled);
  }

  void initCep() {
    widget.cepFocus.addListener(() {
      if (!widget.cepFocus.hasFocus && cep != "") {
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
  static const List<String> sequenciaIlegal = [
    "00000-000",
    "11111-111",
    "22222-222",
    "33333-333",
    "44444-444",
    "55555-555",
    "66666-666",
    "77777-777",
    "88888-888",
    "99999-999"
  ];

  void _validarCEP() {
    if (cep.length < 9 && cep != "") {
      _dialogUtils.showAlertDialogNewAviso(
          "CEP Inválido!", "Por Favor, Termine de digitar o seu cep.");
      widget.validacao(false);
    } else if(sequenciaIlegal.indexOf(cep)  != -1){
      _dialogUtils.showAlertDialogNewAviso(
          "CEP Inválido!", "Por Favor, Digite um cep válido.");
      widget.validacao(false);
    } else {
      widget.validacao(true);
    }
  }
}

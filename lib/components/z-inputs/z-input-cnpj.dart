import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputCNPJ extends StatefulWidget {

  final Key? key;
  FocusNode? cnpjFocus;
  TextEditingController? controllerCNPJ ;
  FocusNode? proximoFocus;
  ValueChanged<String>? onChange;
  void Function(bool)? validacao;
  bool? enabled;
  final bool? campoObrigatorio;
  final ThemeData? themeData;

  ZInputCNPJ(
      {this.key,
       @required this.themeData,
       @required this.cnpjFocus,
       @required this.controllerCNPJ,
        this.onChange,
        this.proximoFocus,
        this.validacao, this.enabled,
        this.campoObrigatorio = false
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZInputCNPJState();
}

class _ZInputCNPJState extends State<ZInputCNPJ> {

  int countcnpj = 1;
  late DialogUtils _dialogUtils;
  late String? cnpj;
  bool? valideCnpj;

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
        "CNPJ",
        TextInputType.number,
            () {

        },
        widget.cnpjFocus,
        widget.controllerCNPJ,
        widget.proximoFocus,
            (text) {
              if (widget.onChange != null) widget.onChange!(text);

              cnpj = text;
              countcnpj = 0;
          if (cnpj!.length == 18) {
            _fieldFocusChange(context, widget.cnpjFocus,
                widget.proximoFocus);
          }
        },true,
        themeData: widget.themeData,
        campoObrigatorio: widget.campoObrigatorio,
        textMask: "##.###.###/####-##",
        hintText: "00.000.000/0000-00",enabled: widget.enabled);
  }

  void initNome() {
    widget.cnpjFocus?.addListener(() {
      if (!widget.cnpjFocus!.hasFocus &&
          countcnpj == 0 &&
          cnpj != "") {
        _validarCNPJ();
      }
    });
  }
  void _fieldFocusChange(
      BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
    currentFocus?.unfocus();
    if (nextFocus != null) {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  void _validarCNPJ() {
    if (!CNPJValidator.isValid(cnpj)) {
      valideCnpj = false;
      _dialogUtils.showAlertDialogNewAviso(
          "CNPJ Inválido!", "Por Favor insira um CNPJ válido.");
      widget.validacao!(false);
    } else {
      valideCnpj = true;
      widget.validacao!(true);
    }
  }

}

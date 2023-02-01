import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputName extends StatefulWidget {
  final Key? key;
  final ThemeData? themeData;
  FocusNode? nomeFocus;
  TextEditingController? controllerNome;
  FocusNode? proximoFocus;
  ValueChanged<String>? onChange;
  String? nomeDoHintText;
  bool? enabled;
  final bool? campoObrigatorio;
  void Function(bool)? validacao;


  ZInputName({
    this.key,
    this.onChange,
    @required this.themeData,
    @required this.nomeFocus,
    @required this.controllerNome,
    this.nomeDoHintText = "",
    this.proximoFocus,this.enabled,
    this.campoObrigatorio = false,
    this.validacao
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZInputNameState();
}

class _ZInputNameState extends State<ZInputName> {
  late DialogUtils _dialogUtils;
  late String? nome;
  int countNome = 1;
  late bool? valideNome;

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
        "Nome",
        TextInputType.text,
        () {

        },
        widget.nomeFocus,
        widget.controllerNome,
        widget.proximoFocus,
        (text) {
          if (widget.onChange != null) widget.onChange!(text);

          nome = text;
          countNome = 0;
        },
        false,
        hintText: widget.nomeDoHintText,
        themeData: widget.themeData,
        campoObrigatorio: widget.campoObrigatorio,
        enabled: widget.enabled);
  }

  void initNome() {
    widget.nomeFocus?.addListener(() {
      if (!widget.nomeFocus!.hasFocus && countNome == 0 && nome != "") {
        _valideNome();
      }
    });
  }

  void _valideNome() {
    if (nome == null) {
      valideNome = false;
      _dialogUtils.showAlertDialogNewAviso(
          "Nome Inválido!", "Por Favor insira o nome completo.");
      widget.validacao!(false);
    } else if (nome!.split(' ').length < 2) {
      valideNome = false;
      _dialogUtils.showAlertDialogNewAviso(
          "Nome Inválido!", "Por Favor insira o nome completo.");
      widget.validacao!(false);
    } else {
      if (nome!.split(' ')[1].length < 2) {
        valideNome = false;
        _dialogUtils.showAlertDialogNewAviso(
            "Nome Inválido!", "Por Favor insira o nome completo.");
        widget.validacao!(false);
      }else{
        valideNome = true;
        widget.validacao!(true);
      }
    }
  }
}

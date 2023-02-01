import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputDataExpiracao extends StatefulWidget {

  final Key? key;
  FocusNode? dataFocus;
  TextEditingController? controllerData;
  String? legenda;
  FocusNode? proximoFocus;
  ValueChanged<String>? onChange;
  void Function(bool)? validacao;
  bool? enabled;
  final ThemeData? themeData;
  final bool? campoObrigatorio;

  late String dia;
  late String ano;
  late String mes;
  late String? nome;
  late String? text;
  late String? hintText;
  late String? total;
  late int? intDias;
  late int? intMes;
  late int? intAno;
  late bool? bisexto;
  late bool? valideMes;

  ZInputDataExpiracao({
    this.key,
    this.onChange,
    @required this.themeData,
    @required this.dataFocus,
    @required this.controllerData,
    @required this.legenda,
    this.proximoFocus,
    this.validacao,this.enabled,
    this.campoObrigatorio = false
  }) : super(key: key);


  @override
  _ZInputDataExpiracaoState createState() => _ZInputDataExpiracaoState();
}

class _ZInputDataExpiracaoState extends State<ZInputDataExpiracao> {
  int countcpf = 1;
  late DialogUtils _dialogUtils;
  late String? data;
  DateTime now = DateTime.now();
  late int? ano;

  @override
  void initState() {
    _dialogUtils = new DialogUtils(context);
    ano = now.year.toInt();
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.styleTextInput(
        context,
        widget.legenda,
        TextInputType.number,
            () {
          //FocusScope.of(context).requestFocus(widget.dataFocus);
        },
        widget.dataFocus,
        widget.controllerData,
        widget.proximoFocus,
            (text) {
          if (widget.onChange != null) widget.onChange!(text);

          data = text;
          countcpf = 0;
          if (data!.length == 10) {
            _fieldFocusChange(context, widget.dataFocus, widget.proximoFocus);
          }
        },
        true,
        themeData: widget.themeData,
        campoObrigatorio: widget.campoObrigatorio,
        textMask: "##/##/####",
        hintText: "dd / mm / aaaa",
        enabled: widget.enabled);
  }

  void initData() {
    widget.dataFocus?.addListener(() {
      if (!widget.dataFocus!.hasFocus && countcpf == 0 && data != "") {
        validaMes(data!);
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

  void validaMes(String data) {
    if (data.length == 10) {
      widget.dia = data.substring(0, 2);
      widget.intDias = int.parse(widget.dia);

      widget.mes = data.substring(3, 5);
      widget.intMes = int.parse(widget.mes);

      widget.ano = data.substring(6, 10);
      widget.intAno = int.parse(widget.ano);

      if ((widget.intAno! % 4 == 0 && widget.intAno! % 100 != 0) ||
          widget.intAno! % 400 == 0) {
        widget.bisexto = true;
      } else {
        widget.bisexto = false;
      }

      print(widget.dia);
      print(widget.mes);
      print(widget.ano);

      var dataDigitada = DateTime(widget.intAno!, widget.intMes!, widget.intDias!);
      var dataAtual = DateTime.now();

      if (widget.intMes! < 13 &&
          widget.intDias! < 32 &&
          widget.intAno! <= ano! &&
          widget.intAno! > 1890) {
        if (widget.intDias == 00 ||
            widget.intMes == 00 ||
            widget.intAno == 00) {
          _dialogUtils.showAlertDialogNewAviso("Data Inválida!",
              "Insira um valor de mês entre 01 e 12, um dia entre 01 e 31, e um ano válido.");
          widget.validacao!(false);
        } else if (widget.intMes == 01 ||
            widget.intMes == 03 ||
            widget.intMes == 05 ||
            widget.intMes == 07 ||
            widget.intMes == 08 ||
            widget.intMes == 10 ||
            widget.intMes == 12) {
          if (widget.intDias! > 31) {
            _dialogUtils.showAlertDialogNewAviso(
                "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
            widget.validacao!(false);
          } else if (dataDigitada.isBefore(dataAtual) == true) {
            _dialogUtils.showAlertDialogNewAviso(
                "Data Inválida!", "Insira uma data futura.");
            widget.validacao!(false);
          } else {
            widget.valideMes = true;
            widget.validacao!(true);
          }
        } else if (widget.intMes == 04 ||
            widget.intMes == 06 ||
            widget.intMes == 09 ||
            widget.intMes == 11) {
          if (widget.intDias! > 30) {
            _dialogUtils.showAlertDialogNewAviso(
                "Dia Inválido!", "Insira um valor de dia entre 01 e 30.");
            widget.validacao!(false);
          } else if (dataDigitada.isBefore(dataAtual) == true) {
            _dialogUtils.showAlertDialogNewAviso(
                "Data Inválida!", "Insira uma data futura.");
            widget.validacao!(false);
          } else {
            widget.valideMes = true;
            widget.validacao!(true);
          }
        } else {
          if (widget.bisexto == true) {
            if (widget.intDias! > 29) {
              _dialogUtils.showAlertDialogNewAviso(
                  "Dia Inválido!", "Insira um valor de dia entre 01 e 29.");
              widget.validacao!(false);
            } else if (dataDigitada.isBefore(dataAtual) == true) {
              _dialogUtils.showAlertDialogNewAviso(
                  "Data Inválida!", "Insira uma data futura.");
              widget.validacao!(false);
            } else {
              widget.valideMes = true;
              widget.validacao!(true);
            }
          } else {
            if (widget.intDias! > 28) {
              _dialogUtils.showAlertDialogNewAviso(
                  "Dia Inválido!", "Insira um valor de dia entre 01 e 28.");
              widget.validacao!(false);
            } else if (dataDigitada.isBefore(dataAtual) == true) {
              _dialogUtils.showAlertDialogNewAviso(
                  "Data Inválida!", "Insira uma data futura.");
              widget.validacao!(false);
            } else {
              widget.valideMes = true;
              widget.validacao!(true);
            }
          }
        }
      } else if (widget.intMes! > 12 &&
          widget.intDias! < 32 &&
          widget.intAno! < ano!) {
        _dialogUtils.showAlertDialogNewAviso(
            "Mês Inválido!", "Insira um valor de mês entre 01 e 12.");
        widget.validacao!(false);
      } else if (widget.intMes! < 13 &&
          widget.intDias! > 31 &&
          widget.intAno! < ano!) {
        _dialogUtils.showAlertDialogNewAviso(
            "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
        widget.validacao!(false);
      } else if (widget.intMes! < 13 &&
          widget.intDias! < 32 &&
          widget.intAno! > ano!) {
        widget.validacao!(true);
      } else if (widget.intMes! > 12 &&
          widget.intDias! < 32 ) {
        _dialogUtils.showAlertDialogNewAviso("Mês !",
            "Insira um valor de mês entre 01 e 12 e um ano entre 1890 e $ano.");
        widget.validacao!(false);
      } else if (widget.intMes! > 12 &&
          widget.intDias! > 32 ) {
        _dialogUtils.showAlertDialogNewAviso("Mês e Dia Inválido!",
            "Insira um valor de mês entre 01 e 12 e dia entre 01 e 31.");
        widget.validacao!(false);
      } else if (widget.intMes! < 13 &&
          widget.intDias! >= 32) {
        _dialogUtils.showAlertDialogNewAviso("Dia",
            "Insira um valor de dia entre 01 e 31 e um ano entre 1950 e $ano.");
        widget.validacao!(false);
      } else if (dataDigitada.isBefore(dataAtual) == true) {
        _dialogUtils.showAlertDialogNewAviso(
            "Data Inválida!", "Insira uma data futura.");
        widget.validacao!(false);
      } else {
        widget.validacao!(true);
      }
    } else {
      _dialogUtils.showAlertDialogNewAviso("Data Incompleta!",
          "Por favor, termine de digitar sua data de nascimento.");
      widget.validacao!(false);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputDataNascimento extends StatefulWidget {
  final Key key;
  FocusNode dataFocus;
  var controllerData = new TextEditingController();
  FocusNode proximoFocus;
  ValueChanged<String> onChange;
  void Function(bool) validacao;

  String dia;
  String ano;
  String mes;
  String nome;
  String text;
  String hintText;
  String total;
  int intDias;
  int intMes;
  int intAno;
  bool bisexto;
  bool valideMes;

  ZInputDataNascimento(
      {this.key,
        this.onChange,
      @required this.dataFocus,
      @required this.controllerData,
       this.proximoFocus,
       this.validacao,
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZInputDataNascimentoState();
}

class _ZInputDataNascimentoState extends State<ZInputDataNascimento> {
  int countcpf = 1;
  DialogUtils _dialogUtils;
  String data;
  DateTime now = DateTime.now();
  int ano;
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
        "Data de Nascimento:",
        TextInputType.number,
        () {
          FocusScope.of(context).requestFocus(widget.dataFocus);
        },
        widget.dataFocus,
        widget.controllerData,
        widget.proximoFocus,
        (text) {
          if (widget.onChange != null) widget.onChange(text);

          data = text;
          countcpf = 0;
          if (data.length == 10) {
            _fieldFocusChange(context, widget.dataFocus, widget.proximoFocus);
          }
        },
        true,
        textMask: "XX/XX/XXXX",
        hintText: "DD / MM / AAAA");
  }

  void initData() {
    widget.dataFocus.addListener(() {
      if (!widget.dataFocus.hasFocus && countcpf == 0 && data != "") {
        validaMes(data);
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

  void validaMes(String data) {
    if(data.length == 10)
      {
        widget.dia = data.substring(0, 2);
        widget.intDias = int.parse(widget.dia);

        widget.mes = data.substring(3, 5);
        widget.intMes = int.parse(widget.mes);

        widget.ano = data.substring(6, 10);
        widget.intAno = int.parse(widget.ano);

        if ((widget.intAno % 4 == 0 && widget.intAno % 100 != 0) ||
            widget.intAno % 400 == 0) {
          widget.bisexto = true;
        } else {
          widget.bisexto = false;
        }

        print(widget.dia);
        print(widget.mes);
        print(widget.ano);

          if (widget.intMes < 13 &&
              widget.intDias < 32 &&
              widget.intAno < 2004 &&
              widget.intAno > 1950) {
            if (widget.intDias == 00 ||
                widget.intMes == 00 ||
                widget.intAno == 00) {
              _dialogUtils.showAlertDialogNewAviso("Data Inválida!",
                  "Insira um valor de mês entre 01 e 12, um dia entre 01 e 31 e um ano abaixo de 2004, não podem ser valores 00.");
              widget.validacao(false);
            } else if (widget.intMes == 01 ||
                widget.intMes == 03 ||
                widget.intMes == 05 ||
                widget.intMes == 07 ||
                widget.intMes == 08 ||
                widget.intMes == 10 ||
                widget.intMes == 12) {
              if (widget.intDias > 31) {
                _dialogUtils.showAlertDialogNewAviso(
                    "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
                widget.validacao(false);

              } else {
                widget.valideMes = true;
                widget.validacao(true);

              }
            } else if (widget.intMes == 04 ||
                widget.intMes == 06 ||
                widget.intMes == 09 ||
                widget.intMes == 11) {
              if (widget.intDias > 30) {
                _dialogUtils.showAlertDialogNewAviso(
                    "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
                widget.validacao(false);
              } else {
                widget.valideMes = true;
                widget.validacao(true);

              }
            } else {
              if (widget.bisexto == true) {
                if (widget.intDias > 29) {
                  _dialogUtils.showAlertDialogNewAviso(
                      "Dia Inválido!", "Insira um valor de dia entre 01 e 29.");
                  widget.validacao(false);

                } else {
                  widget.valideMes = true;
                  widget.validacao(true);

                }
              } else {
                if (widget.intDias > 28) {
                  _dialogUtils.showAlertDialogNewAviso(
                      "Dia Inválido!", "Insira um valor de dia entre 01 e 28.");
                  widget.validacao(false);
                } else {
                  widget.valideMes = true;
                  widget.validacao(true);

                }
              }
            }
          } else if (widget.intMes > 12 &&
              widget.intDias < 32 &&
              widget.intAno < ano) {
            _dialogUtils.showAlertDialogNewAviso(
                "Mês Inválido!", "Insira um valor de mês entre 01 e 12.");
            widget.validacao(false);

          } else if (widget.intMes < 13 &&
              widget.intDias > 32 &&
              widget.intAno < ano) {
            _dialogUtils.showAlertDialogNewAviso(
                "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
            widget.validacao(false);

          }

         else if (widget.intMes < 13 &&
              widget.intDias < 32 &&
              widget.intAno > ano) {
            _dialogUtils.showAlertDialogNewAviso(
                "Ano Inválido!", "Insira um valor de ano entre 1950 e $ano.");
            widget.validacao(false);


          } else if (widget.intAno < 1950) {
            _dialogUtils.showAlertDialogNewAviso(
                "Ano Inválido!", "Insira um valor de ano entre 1950 e $ano.");
            widget.validacao(false);

          } else if (widget.intMes > 12 &&
              widget.intDias < 32 &&
              widget.intAno > ano) {
            _dialogUtils.showAlertDialogNewAviso("Mês e Ano Inválido!",
                "Insira um valor de mês entre 01 e 12 e um ano entre 1950 e $ano.");
            widget.validacao(false);

          } else if (widget.intMes > 12 &&
              widget.intDias > 32 &&
              widget.intAno < ano) {
            _dialogUtils.showAlertDialogNewAviso("Mês e Dia Inválido!",
                "Insira um valor de mês entre 01 e 12 e dia entre 01 e 31.");
            widget.validacao(false);

          } else if (widget.intMes < 13 &&
              widget.intDias > 32 &&
              widget.intAno > ano) {
            _dialogUtils.showAlertDialogNewAviso("Dia e Ano Inválido!",
                "Insira um valor de dia entre 01 e 31 e um ano entre 1950 e $ano.");
            widget.validacao(false);

          }else{
            widget.validacao(true);
          }

      }else{
      _dialogUtils.showAlertDialogNewAviso(
          "Data Incompleta!", "Por favor, termine de digitar sua data de nascimento.");
      widget.validacao(false);
    }

  }

}

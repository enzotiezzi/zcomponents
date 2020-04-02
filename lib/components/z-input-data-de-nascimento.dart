import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputDataNascimento extends StatefulWidget {
  final Key key;
  FocusNode dataFocus;
  var controllerData = new TextEditingController();
  FocusNode proximoFocus;

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
      @required this.dataFocus,
      @required this.controllerData,
      @required this.proximoFocus})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ZInputDataNascimentoState();
}

class ZInputDataNascimentoState extends State<ZInputDataNascimento> {
  int countcpf = 1;
  DialogUtils _dialogUtils;
  String data;
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
        "Data de Nascimento:",
        TextInputType.number,
        () {
          FocusScope.of(context).requestFocus(widget.dataFocus);
        },
        widget.dataFocus,
        widget.controllerData,
        widget.proximoFocus,
        (text) {
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

  void initNome() {
    widget.dataFocus.addListener(() {
      if (!widget.dataFocus.hasFocus && countcpf == 0 && data != "") {
        //metodo
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

  void validaMes() {
    widget.dia = widget.total.substring(0, 2);
    widget.intDias = int.parse(widget.dia);

    widget.mes = widget.total.substring(3, 5);
    widget.intMes = int.parse(widget.mes);

    widget.ano = widget.total.substring(6, 10);
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

    if (widget.total.length == 10) {
      if (widget.intMes < 13 &&
          widget.intDias < 32 &&
          widget.intAno < 2004 &&
          widget.intAno > 1901) {
        if (widget.intDias == 00 ||
            widget.intMes == 00 ||
            widget.intAno == 00) {
          showAlertDialogNew("Data Inválida!",
              "Insira um valor de mês entre 01 e 12, um dia entre 01 e 31 e um ano abaixo de 2004, não podem ser valores 00.");
        } else if (widget.intMes == 01 ||
            widget.intMes == 03 ||
            widget.intMes == 05 ||
            widget.intMes == 07 ||
            widget.intMes == 08 ||
            widget.intMes == 10 ||
            widget.intMes == 12) {
          if (widget.intDias > 31) {
            showAlertDialogNew(
                "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
          } else {
            widget.valideMes = true;
          }
        } else if (widget.intMes == 04 ||
            widget.intMes == 06 ||
            widget.intMes == 09 ||
            widget.intMes == 11) {
          if (widget.intDias > 30) {
            showAlertDialogNew(
                "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
          } else {
            widget.valideMes = true;
          }
        } else {
          if (widget.bisexto == true) {
            if (widget.intDias > 29) {
              showAlertDialogNew(
                  "Dia Inválido!", "Insira um valor de dia entre 01 e 29.");
            } else {
              widget.valideMes = true;
            }
          } else {
            if (widget.intDias > 28) {
              showAlertDialogNew(
                  "Dia Inválido!", "Insira um valor de dia entre 01 e 28.");
            } else {
              widget.valideMes = true;
            }
          }
        }
      } else if (widget.intMes > 12 &&
          widget.intDias < 32 &&
          widget.intAno < 2004) {
        showAlertDialogNew(
            "Mês Inválido!", "Insira um valor de mês entre 01 e 12.");
      } else if (widget.intMes < 13 &&
          widget.intDias > 32 &&
          widget.intAno < 2004) {
        showAlertDialogNew(
            "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
      } else if (widget.intMes < 13 &&
          widget.intDias < 32 &&
          widget.intAno > 2004) {
        showAlertDialogNew(
            "Ano Inválido!", "Insira um valor de ano entre 1901 e 2004.");
      } else if (widget.intAno < 1901) {
        showAlertDialogNew(
            "Ano Inválido!", "Insira um valor de ano entre 1901 e 2004.");
      } else if (widget.intMes > 12 &&
          widget.intDias < 32 &&
          widget.intAno > 2004) {
        showAlertDialogNew("Mês e Ano Inválido!",
            "Insira um valor de mês entre 01 e 12 e um ano entre 1901 e 2004.");
      } else if (widget.intMes > 12 &&
          widget.intDias > 32 &&
          widget.intAno < 2004) {
        showAlertDialogNew("Mês e Dia Inválido!",
            "Insira um valor de mês entre 01 e 12 e dia entre 01 e 31.");
      } else if (widget.intMes < 13 &&
          widget.intDias > 32 &&
          widget.intAno > 2004) {
        showAlertDialogNew("Dia e Ano Inválido!",
            "Insira um valor de dia entre 01 e 31 e um ano entre 1901 e 2004.");
      } else {
        showAlertDialogNew("Data Inválida!",
            "Insira um valor de mês entre 01 e 12, um dia entre 01 e 31 e um ano entre 1901 e 2004.");
      }
    }
  }
  void showAlertDialogNew(String title, String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ZAlertDialog(
        zDialog: ZDialog.erro,
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.all(8),
                  child: new Text(title,
                      style: MainStyle.get(context).styleTittleDialog),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  margin:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: new Text(
                    message,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: const Color(0xff707070),
                        fontSize: MainStyle.get(context).fontSizeEntradaSaida),
                  ),
                )
              ],
            ),
            new Divider(
              color: const Color(0xffdbdbdb),
            ),
            new Container(
              child: new InkWell(
                borderRadius: new BorderRadius.all(const Radius.circular(20.0)),
                splashColor: const Color(0xffe6e6e6),
                onTap: () {
                  Navigator.pop(context);
                },
                child: new Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: new Text(
                    "ENTENDI",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                        MainStyle.get(context).fontSizeLeadinCancelar),
                  ),
                ),
              ),
              margin: const EdgeInsets.only(bottom: 8),
            )
          ],
        ),
      ),
    );
  }
  void mesHasFocus() {
    if (widget.total == null) {
      showAlertDialogNew(
          "Data Inválida!", "Por Favor, digite sua data de nascimento.");
    } else if (widget.total.length < 10) {
      showAlertDialogNew("Data Inválida!",
          "Por Favor, termine de digitar sua data de nascimento");
    }
  }

}

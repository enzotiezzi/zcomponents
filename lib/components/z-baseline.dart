import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/config/z-tipos-baseline.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

class ZBaseLine extends StatelessWidget {
  bool valideMes;
  bool valideCPF;
  bool valideEmail;
  bool valideCelular;
  bool valideNome;

  Widget _zBaseLine;

  final Key key;
  final BuildContext context;
  final ZTipoBaseline zTipos;

  FocusNode nomeFocus;
  FocusNode emailFocus;
  FocusNode cpfFocus;
  FocusNode celularFocus;
  FocusNode mesFocus;

  String dia;
  String ano;
  String mes;
  String nome;

  int intDias;
  int intMes;
  int intAno;

  String total;

  bool bisexto;

  String email;
  String cPF;
  String celular;
  String value;
  var controllerEmail = new TextEditingController();
  var controllerNome = new TextEditingController();
  var controllerCPF = new TextEditingController();
  var controllerCelular = new TextEditingController();
  var controllerData = new TextEditingController();

  ZBaseLine(
      {this.value,
      this.key,
      this.context,
      this.zTipos = ZTipoBaseline.isNomeCompleto,
      this.controllerEmail,
      this.controllerData,
      this.controllerCelular,
      this.controllerCPF,
      this.controllerNome})
      : super(key: key) {
    if (zTipos == ZTipoBaseline.isEmail) {
      init();
    }
    if (zTipos == ZTipoBaseline.isNomeCompleto) {
      initNome();
    }
    if (zTipos == ZTipoBaseline.isCPF) {
      initCpf();
    }
    if (zTipos == ZTipoBaseline.isCelular) {
      initCelular();
    }
    if (zTipos == ZTipoBaseline.isDataNascimento) {
      initMes();
    }

    switch (zTipos) {
      case ZTipoBaseline.isNomeCompleto:
        _zBaseLine = new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text(
                            "Nome Completo",
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            textCapitalization: TextCapitalization.words,
                            focusNode: nomeFocus,
                            controller: controllerNome,
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "Nome Completo",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            onChanged: (text) {
                              nome = text;
                            },
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
      case ZTipoBaseline.isCPF:
        _zBaseLine = new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text(
                            "CPF",
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            controller: controllerCPF,
                            onChanged: (text) {
                              cPF = text;
                            },
                            focusNode: cpfFocus,
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "* . * . * - **",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "XXX.XXX.XXX-XX",
                                  maskTWO: "XXX.XXX.XXX-XX")
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
      case ZTipoBaseline.isCelular:
        _zBaseLine = new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text(
                            "Celular",
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            controller: controllerCelular,
                            focusNode: celularFocus,
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "( * ) 9 ** - ***",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "(XX)XXXXX-XXXX",
                                  maskTWO: "(XX)XXXXX-XXXX"),
                              BlacklistingTextInputFormatter(
                                  RegExp("[\\\\,.]")),
                            ],
                            onChanged: (text) {
                              celular = text;
                            },
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
      case ZTipoBaseline.isEmail:
        _zBaseLine = new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text(
                            "E-mail",
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            controller: controllerEmail,
                            focusNode: emailFocus,
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "email@email.com.br",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            onChanged: (text) {
                              email = text.trim();
                            },
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
      case ZTipoBaseline.isDataNascimento:
        _zBaseLine = new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text(
                            "Data Nascimento",
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            focusNode: mesFocus,
                            controller: controllerData,
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "dd / mm / aaaa",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "XX/XX/XXXX", maskTWO: "XX/XX/XXXX"),
                              BlacklistingTextInputFormatter(
                                  RegExp("[\\\\,.-]")),
                            ],
                            onChanged: (text) {
                              total = text;
                              validaMes();
                            },
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _zBaseLine;
  }

  void initNome() {
    nomeFocus = FocusNode();
    nomeFocus.addListener(() {
      if (!nomeFocus.hasFocus) {
        _valideNome();
      }
    });
  }

  void init() {
    emailFocus = FocusNode();
    emailFocus.addListener(() {
      if (!emailFocus.hasFocus) {
        _validarEmail();
      }
    });
  }

  void initCpf() {
    cpfFocus = FocusNode();
    cpfFocus.addListener(() {
      if (!cpfFocus.hasFocus) {
        _validarCPF();
      }
    });
  }

  void initCelular() {
    celularFocus = FocusNode();
    celularFocus.addListener(() {
      if (!celularFocus.hasFocus) {
        _validarCelular();
      }
    });
  }

  void initMes() {
    mesFocus = FocusNode();
    mesFocus.addListener(() {
      if (!mesFocus.hasFocus) {
        mesHasFocus();
      }
    });
  }

  void validaMes() {
    dia = controllerData.text.substring(0, 2);
    intDias = int.parse(dia);

    mes = controllerData.text.substring(3, 5);
    intMes = int.parse(mes);

    ano = controllerData.text.substring(6, 10);
    intAno = int.parse(ano);

    if ((intAno % 4 == 0 && intAno % 100 != 0) || intAno % 400 == 0) {
      bisexto = true;
    } else {
      bisexto = false;
    }

    print(dia);
    print(mes);
    print(ano);

    if (controllerData.text.length == 10) {
      if (intMes < 13 && intDias < 32 && intAno < 2004 && intAno > 1901) {
        if (intDias == 00 || intMes == 00 || intAno == 00) {
          showAlertDialogNew("Data Inválida!",
              "Insira um valor de mês entre 01 e 12, um dia entre 01 e 31 e um ano abaixo de 2004, não podem ser valores 00.");
        } else if (intMes == 01 ||
            intMes == 03 ||
            intMes == 05 ||
            intMes == 07 ||
            intMes == 08 ||
            intMes == 10 ||
            intMes == 12) {
          if (intDias > 31) {
            showAlertDialogNew(
                "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
          } else {
            valideMes = true;
          }
        } else if (intMes == 04 ||
            intMes == 06 ||
            intMes == 09 ||
            intMes == 11) {
          if (intDias > 30) {
            showAlertDialogNew(
                "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
          } else {
            valideMes = true;
          }
        } else {
          if (bisexto == true) {
            if (intDias > 29) {
              showAlertDialogNew(
                  "Dia Inválido!", "Insira um valor de dia entre 01 e 28.");
            } else {
              valideMes = true;
            }
          } else {
            if (intDias > 28) {
              showAlertDialogNew(
                  "Dia Inválido!", "Insira um valor de dia entre 01 e 28.");
            } else {
              valideMes = true;
            }
          }
        }
      } else if (intMes > 12 && intDias < 32 && intAno < 2004) {
        showAlertDialogNew(
            "Mês Inválido!", "Insira um valor de mês entre 01 e 12.");
      } else if (intMes < 13 && intDias > 32 && intAno < 2004) {
        showAlertDialogNew(
            "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
      } else if (intMes < 13 && intDias < 32 && intAno > 2004) {
        showAlertDialogNew(
            "Ano Inválido!", "Insira um valor de ano entre 1901 e 2004.");
      } else if (intAno < 1901) {
        showAlertDialogNew(
            "Ano Inválido!", "Insira um valor de ano entre 1901 e 2004.");
      } else if (intMes > 12 && intDias < 32 && intAno > 2004) {
        showAlertDialogNew("Mês e Ano Inválido!",
            "Insira um valor de mês entre 01 e 12 e um ano entre 1901 e 2004.");
      } else if (intMes > 12 && intDias > 32 && intAno < 2004) {
        showAlertDialogNew("Mês e Dia Inválido!",
            "Insira um valor de mês entre 01 e 12 e dia entre 01 e 31.");
      } else if (intMes < 13 && intDias > 32 && intAno > 2004) {
        showAlertDialogNew("Dia e Ano Inválido!",
            "Insira um valor de dia entre 01 e 31 e um ano entre 1901 e 2004.");
      } else {
        showAlertDialogNew("Data Inválida!",
            "Insira um valor de mês entre 01 e 12, um dia entre 01 e 31 e um ano entre 1901 e 2004.");
      }
    }
  }

  void mesHasFocus() {
    if (controllerData.text == null) {
      showAlertDialogNew(
          "Data Inválida!", "Por Favor, digite sua data de nascimento.");
    } else if (controllerData.text.length < 10) {
      showAlertDialogNew("Data Inválida!",
          "Por Favor, termine de digitar sua data de nascimento");
    }
  }

  void _valideNome() {
    if (controllerNome.text == null) {
      valideNome = false;
      showAlertDialogNew("Nome Inválido!", "Por Favor insira o nome completo.");
    } else if (controllerNome.text.split(' ').length < 2) {
      valideNome = false;
      showAlertDialogNew("Nome Inválido!", "Por Favor insira o nome completo.");
    } else {
      valideNome = true;
    }
  }

  void _validarCPF() {
    if (!CPFValidator.isValid(controllerCPF.text)) {
      valideCPF = false;
      showAlertDialogNew("CPF Inválido!", "Por Favor insira um CPF válido.");
    } else {
      valideCPF = true;
    }
  }

  void _validarCelular() {
    if (controllerCelular.text == null) {
      valideCelular = false;
      showAlertDialogNew(
          "Celular Inválido!", "Por Favor, digitar o seu celular.");
    } else if (controllerCelular.text.length < 14) {
      valideCelular = false;
      showAlertDialogNew(
          "Celular Inválido!", "Por Favor, Termine de digitar o seu celular.");
    } else {
      valideCelular = true;
    }
  }

  void _validarEmail() {
    if (controllerEmail.text == null) {
      valideEmail = false;
      showAlertDialogNew("E-mail Inválido!", "Por Favor insira um E-mail.");
    } else if (!EmailValidator.validate(controllerEmail.text)) {
      valideEmail = false;
      showAlertDialogNew(
          "E-mail Inválido!", "Por Favor insira um E-mail válido.");
    } else {
      valideEmail = true;
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
                        child: new Text(
                          title,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: new Text(
                          message,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              color: const Color(0xff707070), fontSize: 13),
                        ),
                      )
                    ],
                  ),
                  new Divider(
                    color: const Color(0xffdbdbdb),
                  ),
                  new Container(
                    child: new InkWell(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(20.0)),
                      splashColor: const Color(0xffe6e6e6),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: new Container(
                        padding: const EdgeInsets.all(12),
                        child: new Text(
                          "ENTENDI",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                  )
                ],
              ),
            ));
  }
}

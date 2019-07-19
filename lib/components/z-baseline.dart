import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/config/z-tipos-baseline.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:cpf_cnpj_validator/cnpj_validator.dart';

class ZBaseLine extends StatelessWidget {
  bool valideMes;
  bool valideCPF;
  bool valideEmail;
  bool valideCelular;
  bool valideNome;

  Widget _zBaseLine;
  FocusNode nomeFocus;
  FocusNode emailFocus;
  FocusNode cpfFocus;
  FocusNode celularFocus;
  FocusNode mesFocus;
  FocusNode padraoFocus;
  FocusNode cEPFocus;
  FocusNode cNPJFocus;
  FocusNode proximoFocus;

  final Key key;
  final BuildContext context;
  final ZTipoBaseline zTipos;

  String dia;
  String ano;
  String mes;
  String nome;
  String text;
  String hintText;

  int intDias;
  int intMes;
  int intAno;
  int countNome = 1;
  int countCPF = 1;
  int countCelular = 1;
  int countEmail = 1;
  int countData = 1;
  int countCNPJ = 1;
  int countCEP = 1;

  String total;

  bool bisexto;

  String email;
  String cPF;
  String cNPJ;
  String celular;
  String value;
  var controllerEmail = new TextEditingController();
  var controllerNome = new TextEditingController();
  var controllerCPF = new TextEditingController();
  var controllerCelular = new TextEditingController();
  var controllerData = new TextEditingController();
  var controllerPadrao = new TextEditingController();
  var controllerCEP = new TextEditingController();
  var controllerCNPJ = new TextEditingController();

  var onChangedCEP;


  ZBaseLine(
      {this.value,
      this.key,
      this.context,
      this.zTipos = ZTipoBaseline.isNomeCompleto,
      this.controllerEmail,
      this.controllerData,
      this.controllerCelular,
      this.controllerCPF,
      this.controllerNome,
      this.mesFocus,
      this.emailFocus,
      this.celularFocus,
      this.cpfFocus,
      this.nomeFocus,
      this.controllerPadrao,
      this.hintText,
      this.padraoFocus,
      this.text,
      this.onChangedCEP,
      this.controllerCNPJ,
      this.controllerCEP,
      this.cNPJFocus,
      this.proximoFocus,
      this.cEPFocus})
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
    if (zTipos == ZTipoBaseline.isCNPJ) {
      initCNPJ();
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
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, nomeFocus, proximoFocus);
                            },
                            decoration: InputDecoration(
                              hintText: "Nome Completo",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            onChanged: (text) {
                              nome = text;
                              countNome = 0;
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
                              countCPF = 0;
                              if (cPF.length == 14) {
                                _fieldFocusChange(
                                    context, cpfFocus, proximoFocus);
                              }
                            },
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, cpfFocus, proximoFocus);
                            },
                            focusNode: cpfFocus,
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "*** . *** . *** - **",
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
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, celularFocus, proximoFocus);
                            },
                            decoration: InputDecoration(
                              hintText: "( ** ) 9 **** - ****",
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
                              countCelular = 0;
                              if (celular.length == 14) {
                                _fieldFocusChange(
                                    context, celularFocus, proximoFocus);
                              }
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
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, emailFocus, proximoFocus);
                            },
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
                              countEmail = 0;
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
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, mesFocus, proximoFocus);
                            },
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
                              countData = 0;
                              validaMes();
                              if (text.length == 10) {
                                _fieldFocusChange(
                                    context, mesFocus, proximoFocus);
                              }
                            },
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
      case ZTipoBaseline.semTituloText:
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
                            text,
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, padraoFocus, proximoFocus);
                            },
                            focusNode: padraoFocus,
                            controller: controllerPadrao,
                            keyboardType: TextInputType.text,
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: hintText,
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            onChanged: (text) {},
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
      case ZTipoBaseline.semTituloNumero:
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
                            text,
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, padraoFocus, proximoFocus);
                            },
                            focusNode: padraoFocus,
                            controller: controllerPadrao,
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: hintText,
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            onChanged: (text) {},
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
      case ZTipoBaseline.isCEP:
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
                            "CEP",
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, cEPFocus, proximoFocus);
                            },
                            focusNode: cEPFocus,
                            controller: controllerCEP,
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "CEP",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "XXXXX-XXX", maskTWO: "XXXXX-XXX"),
                              BlacklistingTextInputFormatter(
                                  RegExp("[\\\\,.]")),
                            ],
                            onChanged: onChangedCEP
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
      case ZTipoBaseline.isCNPJ:
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
                            "CNPJ",
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, cNPJFocus, proximoFocus);
                            },
                            controller: controllerCNPJ,
                            onChanged: (text) {
                              cNPJ = text;
                              countCNPJ = 0;
                              if(text.length == 18){
                                _fieldFocusChange(
                                    context, cNPJFocus, proximoFocus);
                              }
                            },
                            focusNode: cNPJFocus,
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "** . *** . *** / **** - **",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "XX.XXX.XXX/XXXX-XX",
                                  maskTWO: "XX.XXX.XXX/XXXX-XX")
                            ],
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
      if (!nomeFocus.hasFocus && countNome == 0) {
        _valideNome();
      }
    });
  }

  void init() {
    emailFocus.addListener(() {
      if (!emailFocus.hasFocus && countEmail == 0) {
        _validarEmail();
      }
    });
  }

  void initCpf() {
    cpfFocus.addListener(() {
      if (!cpfFocus.hasFocus && countCPF == 0) {
        _validarCPF();
      }
    });
  }

  void initCelular() {
    celularFocus.addListener(() {
      if (!celularFocus.hasFocus && countCelular == 0) {
        _validarCelular();
      }
    });
  }

  void initMes() {
    mesFocus.addListener(() {
      if (!mesFocus.hasFocus && countData == 0) {
        mesHasFocus();
      }
    });
  }

  void initCNPJ() {
    cNPJFocus.addListener(() {
      if (!cNPJFocus.hasFocus && countCNPJ == 0) {
        if (!CNPJValidator.isValid(cNPJ)) {
          showAlertDialogNew("Erro", "CNPJ inválido");
        }
      }
    });
  }

  void validaMes() {
    dia = total.substring(0, 2);
    intDias = int.parse(dia);

    mes = total.substring(3, 5);
    intMes = int.parse(mes);

    ano = total.substring(6, 10);
    intAno = int.parse(ano);

    if ((intAno % 4 == 0 && intAno % 100 != 0) || intAno % 400 == 0) {
      bisexto = true;
    } else {
      bisexto = false;
    }

    print(dia);
    print(mes);
    print(ano);

    if (total.length == 10) {
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
    if (total == null) {
      showAlertDialogNew(
          "Data Inválida!", "Por Favor, digite sua data de nascimento.");
    } else if (total.length < 10) {
      showAlertDialogNew("Data Inválida!",
          "Por Favor, termine de digitar sua data de nascimento");
    }
  }

  void _valideNome() {
    if (nome == null) {
      valideNome = false;
      showAlertDialogNew("Nome Inválido!", "Por Favor insira o nome completo.");
    } else if (nome.split(' ').length < 2) {
      valideNome = false;
      showAlertDialogNew("Nome Inválido!", "Por Favor insira o nome completo.");
    } else {
      valideNome = true;
    }
  }

  void _validarCPF() {
    if (!CPFValidator.isValid(cPF)) {
      valideCPF = false;
      showAlertDialogNew("CPF Inválido!", "Por Favor insira um CPF válido.");
    } else {
      valideCPF = true;
    }
  }

  void _validarCelular() {
    if (celular == null) {
      valideCelular = false;
      showAlertDialogNew(
          "Celular Inválido!", "Por Favor, digitar o seu celular.");
    } else if (celular.length < 14) {
      valideCelular = false;
      showAlertDialogNew(
          "Celular Inválido!", "Por Favor, Termine de digitar o seu celular.");
    } else {
      valideCelular = true;
    }
  }

  void _validarEmail() {
    if (email == null) {
      valideEmail = false;
      showAlertDialogNew("E-mail Inválido!", "Por Favor insira um E-mail.");
    } else if (!EmailValidator.validate(email)) {
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

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    if (nextFocus != null) {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }


}

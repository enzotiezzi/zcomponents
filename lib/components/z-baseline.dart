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
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:z_components/styles/main-style.dart';

class ZBaseLine extends StatefulWidget {
  bool enable;
  bool valideMes;
  bool valideCPF;
  bool valideEmail;
  bool valideCelular;
  bool valideNome;

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
  var onChangedTextPadrao;
  var onChangedCEP;

  ZBaseLine(
      {this.enable = true,
      this.value,
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
      this.onChangedTextPadrao,
      this.controllerCNPJ,
      this.controllerCEP,
      this.cNPJFocus,
      this.proximoFocus,
      this.cEPFocus})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ZBaseLineState();
}

class ZBaseLineState extends State<ZBaseLine> {
  @override
  void initState() {
    if (widget.zTipos == ZTipoBaseline.isEmail) {
      init();
    }
    if (widget.zTipos == ZTipoBaseline.isNomeCompleto) {
      initNome();
    }
    if (widget.zTipos == ZTipoBaseline.isCPF) {
      initCpf();
    }
    if (widget.zTipos == ZTipoBaseline.isCelular) {
      initCelular();
    }
    if (widget.zTipos == ZTipoBaseline.isDataNascimento) {
      initMes();
    }
    if (widget.zTipos == ZTipoBaseline.isCNPJ) {
      initCNPJ();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.zTipos) {
      case ZTipoBaseline.isNomeCompleto:
        return new Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(widget.nomeFocus),
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 3,
                      child: new Container(
                        padding: const EdgeInsets.only(
                            top: 12.0, bottom: 12.0, left: 16.0),
                        child: new Text("Nome Completo",
                            style:
                                MainStyle.get(context).mainStyleTextBaseLine),
                      ),
                    ),
                    new Expanded(
                      flex: 7,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                        child: new TextField(
                          keyboardAppearance: Brightness.light,
                          textCapitalization: TextCapitalization.words,
                          focusNode: widget.nomeFocus,
                          controller: widget.controllerNome,
                          cursorColor: Color(0xFF2BBAB4),
                          style:
                              MainStyle.get(context).mainStyleTextBaseLineInput,
                          inputFormatters: [
                            BlacklistingTextInputFormatter(RegExp("[\\\\/,.]")),
                          ],
                          onSubmitted: (text) {
                            _fieldFocusChange(
                                context, widget.nomeFocus, widget.proximoFocus);
                          },
                          decoration: InputDecoration(
                            hintText: "Nome Completo",
                            hintStyle: MainStyle.get(context)
                                .mainStyleTextBaseLineHint,
                          ),
                          onChanged: (text) {
                            widget.nome = text;
                            widget.countNome = 0;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        break;
      case ZTipoBaseline.isCPF:
        return new Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(widget.cpfFocus),
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
                          style: MainStyle.get(context).mainStyleTextBaseLine,
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 7,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                        child: new TextField(
                          enabled: this.widget.enable,
                          keyboardAppearance: Brightness.light,
                          controller: widget.controllerCPF,
                          onChanged: (text) {
                            widget.cPF = text;
                            widget.countCPF = 0;
                            if (widget.cPF.length == 14) {
                              _fieldFocusChange(context, widget.cpfFocus,
                                  widget.proximoFocus);
                            }
                          },
                          onSubmitted: (text) {
                            _fieldFocusChange(
                                context, widget.cpfFocus, widget.proximoFocus);
                          },
                          focusNode: widget.cpfFocus,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xFF2BBAB4),
                          style:
                              MainStyle.get(context).mainStyleTextBaseLineInput,
                          decoration: InputDecoration(
                            hintText: "*** . *** . *** - **",
                            hintStyle: MainStyle.get(context)
                                .mainStyleTextBaseLineHint,
                          ),
                          inputFormatters: [
                            MaskedTextInputFormatterShifter(
                                maskONE: "XXX.XXX.XXX-XX",
                                maskTWO: "XXX.XXX.XXX-XX")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
        break;
      case ZTipoBaseline.isCelular:
        return new Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: () =>
                FocusScope.of(context).requestFocus(widget.celularFocus),
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text("Celular",
                              style:
                                  MainStyle.get(context).mainStyleTextBaseLine),
                        )),
                    new Expanded(
                      flex: 7,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                        child: new TextField(
                          keyboardAppearance: Brightness.light,
                          controller: widget.controllerCelular,
                          focusNode: widget.celularFocus,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xFF2BBAB4),
                          style:
                              MainStyle.get(context).mainStyleTextBaseLineInput,
                          onSubmitted: (text) {
                            _fieldFocusChange(context, widget.celularFocus,
                                widget.proximoFocus);
                          },
                          decoration: InputDecoration(
                            hintText: "( ** ) 9 **** - ****",
                            hintStyle: MainStyle.get(context)
                                .mainStyleTextBaseLineHint,
                          ),
                          inputFormatters: [
                            MaskTextInputFormatter(
                                mask: "(##) # ####-####",
                                filter: {"#": RegExp(r'[0-9]')}),
                            BlacklistingTextInputFormatter(RegExp("[\\\\,.]")),
                          ],
                          onChanged: (text) {
                            widget.celular = text;
                            widget.countCelular = 0;
                            if (widget.celular.length == 16) {
                              _fieldFocusChange(context, widget.celularFocus,
                                  widget.proximoFocus);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        break;
      case ZTipoBaseline.isEmail:
        return new Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(widget.emailFocus),
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
                          style: MainStyle.get(context).mainStyleTextBaseLine,
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 7,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                        child: new TextField(
                          keyboardAppearance: Brightness.light,
                          onSubmitted: (text) {
                            _fieldFocusChange(context, widget.emailFocus,
                                widget.proximoFocus);
                          },
                          controller: widget.controllerEmail,
                          focusNode: widget.emailFocus,
                          cursorColor: Color(0xFF2BBAB4),
                          style:
                              MainStyle.get(context).mainStyleTextBaseLineInput,
                          decoration: InputDecoration(
                            hintText: "email@email.com.br",
                            hintStyle: MainStyle.get(context)
                                .mainStyleTextBaseLineHint,
                          ),
                          onChanged: (text) {
                            widget.email = text.trim();
                            widget.countEmail = 0;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
        break;
      case ZTipoBaseline.isDataNascimento:
        return new Container(
          color: Colors.white,
          child: new GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(widget.mesFocus),
            child: Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text("Data de Nascimento",
                              style:
                                  MainStyle.get(context).mainStyleTextBaseLine),
                        )),
                    new Expanded(
                      flex: 7,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                        child: new TextField(
                          onSubmitted: (text) {
                            _fieldFocusChange(
                                context, widget.mesFocus, widget.proximoFocus);
                          },
                          focusNode: widget.mesFocus,
                          controller: widget.controllerData,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xFF2BBAB4),
                          style:
                              MainStyle.get(context).mainStyleTextBaseLineInput,
                          keyboardAppearance: Brightness.light,
                          decoration: InputDecoration(
                            hintText: "dd / mm / aaaa",
                            hintStyle: MainStyle.get(context)
                                .mainStyleTextBaseLineHint,
                          ),
                          inputFormatters: [
                            MaskedTextInputFormatterShifter(
                                maskONE: "XX/XX/XXXX", maskTWO: "XX/XX/XXXX"),
                            BlacklistingTextInputFormatter(RegExp("[\\\\,.-]")),
                          ],
                          onChanged: (text) {
                            widget.total = text;
                            widget.countData = 0;
                            validaMes();
                            if (text.length == 10) {
                              _fieldFocusChange(context, widget.mesFocus,
                                  widget.proximoFocus);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        break;
      case ZTipoBaseline.semTituloText:
        return new Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: () =>
                FocusScope.of(context).requestFocus(widget.padraoFocus),
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
                            widget.text,
                            style: MainStyle.get(context).mainStyleTextBaseLine,
                          ),
                        )),
                    new Expanded(
                      flex: 7,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                        child: new TextField(
                          enabled: widget.enable,
                          keyboardAppearance: Brightness.light,
                          onSubmitted: (text) {
                            _fieldFocusChange(context, widget.padraoFocus,
                                widget.proximoFocus);
                          },
                          focusNode: widget.padraoFocus,
                          controller: widget.controllerPadrao,
                          keyboardType: TextInputType.text,
                          cursorColor: Color(0xFF2BBAB4),
                          style:
                              MainStyle.get(context).mainStyleTextBaseLineInput,
                          decoration: InputDecoration(
                            hintText: widget.hintText,
                            hintStyle: MainStyle.get(context)
                                .mainStyleTextBaseLineHint,
                          ),
                          onChanged: widget.onChangedTextPadrao,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        break;
      case ZTipoBaseline.semTituloNumero:
        return new Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: () =>
                FocusScope.of(context).requestFocus(widget.padraoFocus),
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 3,
                      child: new Container(
                        padding: const EdgeInsets.only(
                            top: 12.0, bottom: 12.0, left: 16.0),
                        child: new Text(widget.text,
                            style:
                                MainStyle.get(context).mainStyleTextBaseLine),
                      ),
                    ),
                    new Expanded(
                      flex: 7,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                        child: new TextField(
                          enabled: widget.enable,
                          keyboardAppearance: Brightness.light,
                          onSubmitted: (text) {
                            _fieldFocusChange(context, widget.padraoFocus,
                                widget.proximoFocus);
                          },
                          focusNode: widget.padraoFocus,
                          controller: widget.controllerPadrao,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xFF2BBAB4),
                          style:
                              MainStyle.get(context).mainStyleTextBaseLineInput,
                          decoration: InputDecoration(
                            hintText: widget.hintText,
                            hintStyle: MainStyle.get(context)
                                .mainStyleTextBaseLineHint,
                          ),
                          onChanged: (text) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        break;
      case ZTipoBaseline.isCEP:
        return new Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(widget.cEPFocus),
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 3,
                      child: new Container(
                        padding: const EdgeInsets.only(
                            top: 12.0, bottom: 12.0, left: 16.0),
                        child: new Text("CEP",
                            style:
                                MainStyle.get(context).mainStyleTextBaseLine),
                      ),
                    ),
                    new Expanded(
                      flex: 7,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                        child: new TextField(
                            keyboardAppearance: Brightness.light,
                            onSubmitted: (text) {
                              _fieldFocusChange(context, widget.cEPFocus,
                                  widget.proximoFocus);
                            },
                            focusNode: widget.cEPFocus,
                            controller: widget.controllerCEP,
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0xFF2BBAB4),
                            style: MainStyle.get(context)
                                .mainStyleTextBaseLineInput,
                            decoration: InputDecoration(
                              hintText: "CEP",
                              hintStyle: MainStyle.get(context)
                                  .mainStyleTextBaseLineHint,
                            ),
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "XXXXX-XXX", maskTWO: "XXXXX-XXX"),
                              BlacklistingTextInputFormatter(
                                  RegExp("[\\\\,.]")),
                            ],
                            onChanged: widget.onChangedCEP),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        break;
      case ZTipoBaseline.isCNPJ:
        return new Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(widget.cNPJFocus),
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 3,
                      child: new Container(
                        padding: const EdgeInsets.only(
                            top: 12.0, bottom: 12.0, left: 16.0),
                        child: new Text("CNPJ",
                            style:
                                MainStyle.get(context).mainStyleTextBaseLine),
                      ),
                    ),
                    new Expanded(
                      flex: 7,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                        child: new TextField(
                          keyboardAppearance: Brightness.light,
                          onSubmitted: (text) {
                            _fieldFocusChange(
                                context, widget.cNPJFocus, widget.proximoFocus);
                          },
                          controller: widget.controllerCNPJ,
                          onChanged: (text) {
                            widget.cNPJ = text;
                            widget.countCNPJ = 0;
                            if (text.length == 18) {
                              _fieldFocusChange(context, widget.cNPJFocus,
                                  widget.proximoFocus);
                            }
                          },
                          focusNode: widget.cNPJFocus,
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xFF2BBAB4),
                          style:
                              MainStyle.get(context).mainStyleTextBaseLineInput,
                          decoration: InputDecoration(
                            hintText: "** . *** . *** / **** - **",
                            hintStyle: MainStyle.get(context)
                                .mainStyleTextBaseLineHint,
                          ),
                          inputFormatters: [
                            MaskedTextInputFormatterShifter(
                                maskONE: "XX.XXX.XXX/XXXX-XX",
                                maskTWO: "XX.XXX.XXX/XXXX-XX"),
                            BlacklistingTextInputFormatter(RegExp("[ ]")),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        break;
    }
    return build(context);
  }

  void initNome() {
    widget.nomeFocus = FocusNode();
    widget.nomeFocus.addListener(() {
      if (!widget.nomeFocus.hasFocus &&
          widget.countNome == 0 &&
          widget.nome != "") {
        _valideNome();
      }
    });
  }

  void init() {
    widget.emailFocus.addListener(() {
      if (!widget.emailFocus.hasFocus &&
          widget.countEmail == 0 &&
          widget.email != "") {
        _validarEmail();
      }
    });
  }

  void initCpf() {
    widget.cpfFocus.addListener(() {
      if (!widget.cpfFocus.hasFocus &&
          widget.countCPF == 0 &&
          widget.cPF != "") {
        _validarCPF();
      }
    });
  }

  void initCelular() {
    widget.celularFocus.addListener(() {
      if (!widget.celularFocus.hasFocus &&
          widget.countCelular == 0 &&
          widget.celular != "") {
        _validarCelular();
      }
    });
  }

  void initMes() {
    widget.mesFocus.addListener(() {
      if (!widget.mesFocus.hasFocus &&
          widget.countData == 0 &&
          widget.total != "") {
        mesHasFocus();
      }
    });
  }

  void initCNPJ() {
    widget.cNPJFocus.addListener(() {
      if (!widget.cNPJFocus.hasFocus &&
          widget.countCNPJ == 0 &&
          widget.cNPJ != "") {
        if (!CNPJValidator.isValid(widget.cNPJ)) {
          showAlertDialogNew("Erro", "CNPJ inválido");
        }
      }
    });
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

  void mesHasFocus() {
    if (widget.total == null) {
      showAlertDialogNew(
          "Data Inválida!", "Por Favor, digite sua data de nascimento.");
    } else if (widget.total.length < 10) {
      showAlertDialogNew("Data Inválida!",
          "Por Favor, termine de digitar sua data de nascimento");
    }
  }

  void _valideNome() {
    if (widget.nome == null) {
      widget.valideNome = false;
      showAlertDialogNew("Nome Inválido!", "Por Favor insira o nome completo.");
    } else if (widget.nome.split(' ').length < 2) {
      widget.valideNome = false;
      showAlertDialogNew("Nome Inválido!", "Por Favor insira o nome completo.");
    } else {
      widget.valideNome = true;
    }
  }

  void _validarCPF() {
    if (!CPFValidator.isValid(widget.cPF)) {
      widget.valideCPF = false;
      showAlertDialogNew("CPF Inválido!", "Por Favor insira um CPF válido.");
    } else {
      widget.valideCPF = true;
    }
  }

  void _validarCelular() {
    if (widget.celular == null) {
      widget.valideCelular = false;
      showAlertDialogNew(
          "Celular Inválido!", "Por Favor, digitar o seu celular.");
    } else if (widget.celular.length < 16) {
      widget.valideCelular = false;
      showAlertDialogNew(
          "Celular Inválido!", "Por Favor, Termine de digitar o seu celular.");
    } else if (widget.celular.length == 16) {
      var splitCelular = widget.celular.split(" ");

      if (splitCelular[1] == "9") {
        widget.valideCelular = true;
      } else {
        widget.valideCelular = false;
        showAlertDialogNew("Celular Inválido!",
            "Os celulares no Brasil devem começar com 9. Por Favor digite novamente o seu celular.");
      }
    }
  }

  void _validarEmail() {
    if (widget.email == null) {
      widget.valideEmail = false;
      showAlertDialogNew("E-mail Inválido!", "Por Favor insira um E-mail.");
    } else if (!EmailValidator.validate(widget.email)) {
      widget.valideEmail = false;
      showAlertDialogNew(
          "E-mail Inválido!", "Por Favor insira um E-mail válido.");
    } else {
      widget.valideEmail = true;
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

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    if (nextFocus != null) {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}

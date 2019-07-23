import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/components/z-check-cpf.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z-pin-senha.dart';
import 'package:z_components/components/z_button.dart';
import 'package:z_components/config/z-button-type.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/config/z-tipo-senha.dart';

class ZCadastroUsuario extends StatefulWidget {
  Widget zTelaCadastro;
  Widget tituloAppBar;

  Key key;

  final BuildContext context;
  var controllerEmail = new TextEditingController();
  var controllerNome = new TextEditingController();
  var controllerCPF = new TextEditingController();
  var controllerCelular = new TextEditingController();
  var onPressed;
  var controllerData = new TextEditingController();
  var controllerSenha = new TextEditingController();
  var controllerRepetirSenha = new TextEditingController();

  var onTapVoltar;

  ZCadastroUsuario({
    this.controllerRepetirSenha,
    this.controllerSenha,
    this.tituloAppBar,
    this.onTapVoltar,
    this.key,
    this.context,
    this.onPressed,
    this.controllerData,
    this.controllerCelular,
    this.controllerCPF,
    this.controllerNome,
    this.controllerEmail,
  });

  @override
  _ZCadastroUsuarioState createState() => _ZCadastroUsuarioState();
}

class _ZCadastroUsuarioState extends State<ZCadastroUsuario>
    with TickerProviderStateMixin {
  int countNome = 1;
  int countCPF = 1;
  int countCelular = 1;
  int countEmail = 1;
  int countData = 1;
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
  bool bisexto;
  int intDias;
  int intMes;
  int intAno;

  String dia;
  String ano;
  String mes;

  String teste;
  bool _termos = false;

  @override
  void initState() {
    init();
    initMes();
    initCelular();
    initCpf();
    initNome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0xffefeff4),
        appBar: CupertinoNavigationBar(
          middle: widget.tituloAppBar,
          leading: new GestureDetector(
            onTap: widget.onTapVoltar,
            child: new Container(
              padding: EdgeInsets.only(right: 20.0),
              color: Colors.transparent,
              child: new Icon(
                Icons.arrow_back_ios,
                size: 20.0,
                color: const Color(0xff2BB9B4),
              ),
            ),
          ),
        ),
        body: _body());
  }

  Widget _body() {
    return new Column(
      children: <Widget>[
        _titulo(),
        new Expanded(
          child: _buildBody(),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return new ListView(
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
          alignment: Alignment.centerLeft,
          child: new Text(
            "DADOS PESSOAIS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
        ),
        new Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: new Column(
            children: <Widget>[
              new Container(
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
                                  style:
                                      new TextStyle(color: Color(0xFF999999)),
                                ),
                              )),
                          new Expanded(
                              flex: 7,
                              child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 8.0, right: 16.0),
                                child: new TextField(
                                  keyboardAppearance: Brightness.light,
                                  onSubmitted: (term) {
                                    _fieldFocusChange(
                                        context, nomeFocus, cpfFocus);
                                  },
                                  onChanged: (text) {
                                    countNome = 0;
                                  },
                                  textCapitalization: TextCapitalization.words,
                                  focusNode: nomeFocus,
                                  controller: widget.controllerNome,
                                  cursorColor: Color(0xFF2BBAB4),
                                  style:
                                      new TextStyle(color: Color(0xFF000000)),
                                  decoration: InputDecoration(
                                    hintText: "Nome Completo",
                                    hintStyle: new TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            Color(0xFF000000).withOpacity(0.3)),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ],
                  )),
              new Container(
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
                                  style:
                                      new TextStyle(color: Color(0xFF999999)),
                                ),
                              )),
                          new Expanded(
                              flex: 7,
                              child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 8.0, right: 16.0),
                                child: new TextField(
                                  keyboardAppearance: Brightness.light,

                                  onSubmitted: (term) {
                                    _fieldFocusChange(
                                        context, cpfFocus, celularFocus);
                                  },
                                  onChanged: (text) {
                                    countCPF = 0;
                                    if (text.length == 14) {
                                      _fieldFocusChange(
                                          context, cpfFocus, celularFocus);
                                    }
                                  },
                                  controller: widget.controllerCPF,
                                  focusNode: cpfFocus,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Color(0xFF2BBAB4),
                                  style:
                                      new TextStyle(color: Color(0xFF000000)),
                                  decoration: InputDecoration(
                                    isDense: false,
                                    hintText: "*** . *** . *** - **",
                                    hintStyle: new TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            Color(0xFF000000).withOpacity(0.3)),
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
                  )),
              new Container(
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
                                  style:
                                      new TextStyle(color: Color(0xFF999999)),
                                ),
                              )),
                          new Expanded(
                              flex: 7,
                              child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 8.0, right: 16.0),
                                child: new TextField(
                                  keyboardAppearance: Brightness.light,

                                  onSubmitted: (term) {
                                    _fieldFocusChange(
                                        context, celularFocus, emailFocus);
                                  },
                                  onChanged: (text) {
                                    countCelular = 0;
                                    if (text.length == 14) {
                                      _fieldFocusChange(
                                          context, celularFocus, emailFocus);
                                    }
                                  },
                                  controller: widget.controllerCelular,
                                  focusNode: celularFocus,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Color(0xFF2BBAB4),
                                  style:
                                      new TextStyle(color: Color(0xFF000000)),
                                  decoration: InputDecoration(
                                    hintText: "( ** ) 9 **** - ****",
                                    hintStyle: new TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            Color(0xFF000000).withOpacity(0.3)),
                                  ),
                                  inputFormatters: [
                                    MaskedTextInputFormatterShifter(
                                        maskONE: "(XX)XXXXX-XXXX",
                                        maskTWO: "(XX)XXXXX-XXXX"),
                                    BlacklistingTextInputFormatter(
                                        RegExp("[\\\\,.]")),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ],
                  )),
              new Container(
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
                                  style:
                                      new TextStyle(color: Color(0xFF999999)),
                                ),
                              )),
                          new Expanded(
                              flex: 7,
                              child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 8.0, right: 16.0),
                                child: new TextField(
                                  keyboardAppearance: Brightness.light,

                                  onSubmitted: (term) {
                                    _fieldFocusChange(
                                        context, emailFocus, mesFocus);
                                  },
                                  onChanged: (text) {
                                    countEmail = 0;
                                  },
                                  controller: widget.controllerEmail,
                                  focusNode: emailFocus,
                                  cursorColor: Color(0xFF2BBAB4),
                                  style:
                                      new TextStyle(color: Color(0xFF000000)),
                                  decoration: InputDecoration(
                                    hintText: "email@email.com.br",
                                    hintStyle: new TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            Color(0xFF000000).withOpacity(0.3)),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ],
                  )),
              new Container(
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
                                  style:
                                      new TextStyle(color: Color(0xFF999999)),
                                ),
                              )),
                          new Expanded(
                              flex: 7,
                              child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 8.0, right: 16.0),
                                child: new TextField(
                                  keyboardAppearance: Brightness.light,

                                  onSubmitted: (term) {
                                    mesFocus.unfocus();
                                  },
                                  onChanged: (text) {
                                    countData = 0;
                                    validaMes();
                                    if (text.length == 10) {
                                      mesFocus.unfocus();
                                    }
                                  },
                                  focusNode: mesFocus,
                                  controller: widget.controllerData,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Color(0xFF2BBAB4),
                                  style:
                                      new TextStyle(color: Color(0xFF000000)),
                                  decoration: InputDecoration(
                                    hintText: "dd / mm / aaaa",
                                    hintStyle: new TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            Color(0xFF000000).withOpacity(0.3)),
                                  ),
                                  inputFormatters: [
                                    MaskedTextInputFormatterShifter(
                                        maskONE: "XX/XX/XXXX",
                                        maskTWO: "XX/XX/XXXX"),
                                    BlacklistingTextInputFormatter(
                                        RegExp("[\\\\,.-]")),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 5.0),
          alignment: Alignment.centerRight,
          child: new ZCheckCPF(),
        ),
        new Container(
          padding: EdgeInsets.only(left: 15.0, bottom: 15.0, top: 8),
          alignment: Alignment.centerLeft,
          child: new Text(
            "SEGURANÇA",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
        ),
        new ZPinSenha(
          onChange: (text) {
            widget.controllerSenha.text = text;
          },
          context: context,
          numeroQuadrados: 4,
          zTipos: ZTipoSenha.isSenha,
        ),
        new ZPinSenha(
          onChange: (text) {
            widget.controllerRepetirSenha.text = text;
          },
          context: context,
          numeroQuadrados: 4,
          zTipos: ZTipoSenha.isRepetirSenha,
        ),
        new Container(
          child: new GestureDetector(
            onTap: () {
              setState(() {
                _termos = !_termos;
              });
            },
            child: new Container(
                margin: EdgeInsets.only(
                    left: 75.0, right: 75.0, top: 15.0, bottom: 0.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: new Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 1,
                    child: new Container(
                      padding: EdgeInsets.all(2),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                              decoration: BoxDecoration(
                                  color: (_termos == false)
                                      ? Colors.white
                                      : Color(0xff2BB9B4),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.6)),
                                  shape: BoxShape.circle),
                              height: 25.0,
                              width: 25.0,
                              child: new AnimatedSize(
                                duration: Duration(milliseconds: 5000),
                                curve: Curves.fastOutSlowIn,
                                vsync: this,
                                child: new Icon(Icons.check,
                                    color: Colors.white,
                                    size: (_termos == true) ? 20.0 : 0.0),
                              )),
                          new Container(
                            margin: EdgeInsets.only(left: 4.0),
                            child: new Text(
                              "ACEITO OS TERMOS DE USO",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0,
                                  color: const Color(0xff2BB9B4)),
                            ),
                          )
                        ],
                      ),
                    ))),
          ),
        ),
        new Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 20.0, top: 40),
            child: (_termos == false)
                ? ZButton(
                    color: Colors.grey,
                    padding: EdgeInsets.only(
                        top: 12.0, bottom: 12.0, right: 40.0, left: 40.0),
                    zButtonType: ZButtonType.isContained,
                    text: "CADASTRAR USUÁRIO",
                    onPressed: (){},

                  )
                : ZButton(
                    padding: EdgeInsets.only(
                        top: 12.0, bottom: 12.0, right: 40.0, left: 40.0),
                    zButtonType: ZButtonType.isContained,
                    text: "CADASTRAR USUÁRIO",
                    onPressed: widget.onPressed,
                  )),
      ],
    );
  }

  Widget _titulo() {
    return new ZHeader(
      titulo: "CADASTRO DE USUÁRIO",
    );
  }

  void validaMes() {
    dia = widget.controllerData.text.substring(0, 2);
    intDias = int.parse(dia);

    mes = widget.controllerData.text.substring(3, 5);
    intMes = int.parse(mes);

    ano = widget.controllerData.text.substring(6, 10);
    intAno = int.parse(ano);

    if ((intAno % 4 == 0 && intAno % 100 != 0) || intAno % 400 == 0) {
      bisexto = true;
    } else {
      bisexto = false;
    }

    if (widget.controllerData.text.length == 10) {
      if (intMes < 13 && intDias < 32 && intAno < 2004 && intAno > 1901) {
        if (intDias == 00 || intMes == 00 || intAno == 00) {
//          showAlertDialogNew("Data Inválida!",
//              "Insira um valor de mês entre 01 e 12, um dia entre 01 e 31 e um ano abaixo de 2004, não podem ser valores 00.");
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

  void initNome() {
    nomeFocus = FocusNode();
    nomeFocus.addListener(() {
      if (!nomeFocus.hasFocus && countNome == 0) {
        _valideNome();
      }
    });
  }

  void init() {
    emailFocus = FocusNode();
    emailFocus.addListener(() {
      if (!emailFocus.hasFocus && countEmail == 0) {
        _validarEmail();
      }
    });
  }

  void initCpf() {
    cpfFocus = FocusNode();
    cpfFocus.addListener(() {
      if (!cpfFocus.hasFocus && countCPF == 0) {
        _validarCPF();
      }
    });
  }

  void initCelular() {
    celularFocus = FocusNode();
    celularFocus.addListener(() {
      if (!celularFocus.hasFocus && countCelular == 0) {
        _validarCelular();
      }
    });
  }

  void initMes() {
    mesFocus = FocusNode();
    mesFocus.addListener(() {
      if (!mesFocus.hasFocus && countData == 0) {
        mesHasFocus();
      }
    });
  }

  void mesHasFocus() {
   if (widget.controllerData.text.length < 10 && widget.controllerData.text.length >= 1) {
      showAlertDialogNew("Data Inválida!",
          "Por Favor, termine de digitar sua data de nascimento");
    }
  }

  void _valideNome() {
    if (widget.controllerNome.text.split(' ').length < 2 && widget.controllerNome.text.length >=1) {
      valideNome = false;
      showAlertDialogNew("Nome Inválido!", "Por Favor insira o nome completo.");
    } else {
      valideNome = true;
    }
  }

  void _validarCPF() {
    if (!CPFValidator.isValid(widget.controllerCPF.text) && widget.controllerCPF.text.length >= 1) {
      valideCPF = false;
      showAlertDialogNew("CPF Inválido!", "Por Favor insira um CPF válido.");
    } else {
      valideCPF = true;
    }
  }

  void _validarCelular() {
    if (widget.controllerCelular.text.length < 14 && widget.controllerCelular.text.length >= 1 ) {
      valideCelular = false;
      showAlertDialogNew(
          "Celular Inválido!", "Por Favor, Termine de digitar o seu celular.");
    } else {
      valideCelular = true;
    }
  }

  void _validarEmail() {
   if (!EmailValidator.validate(widget.controllerEmail.text.trim()) && widget.controllerEmail.text.length >= 1) {
      valideEmail = false;
      showAlertDialogNew(
          "E-mail Inválido!", "Por Favor insira um E-mail válido.");
    } else {
      valideEmail = true;
    }
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

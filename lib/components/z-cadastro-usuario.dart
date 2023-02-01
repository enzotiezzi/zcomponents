import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_shifter_v2/mask_shifter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/components/z-check-cpf.dart';
import 'package:z_components/components/z-pin-senha.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/config/z-tipo-senha.dart';
import 'package:z_components/styles/main-style.dart';

class ZCadastroUsuario extends StatefulWidget {
  Widget? zTelaCadastro;
  var onTapTermosUso;
  bool? termos;
  Key? key;

  final bool? possuiCPF;

  final BuildContext? context;
  TextEditingController? controllerEmail = new TextEditingController();
  TextEditingController? controllerNome = new TextEditingController();
  TextEditingController? controllerCPF = new TextEditingController();
  TextEditingController? controllerCelular = new TextEditingController();
  late var onPressed;
  TextEditingController? controllerData = new TextEditingController();
  TextEditingController? controllerSenha = new TextEditingController();
  TextEditingController? controllerRepetirSenha = new TextEditingController();

  var onTapVoltar;

  ZCadastroUsuario(
      {this.controllerRepetirSenha,
      this.controllerSenha,
      this.possuiCPF = true,
      this.onTapVoltar,
      this.key,
      this.context,
      this.onPressed,
      this.controllerData,
      this.controllerCelular,
      this.controllerCPF,
      this.controllerNome,
      this.controllerEmail,
      this.onTapTermosUso,
      this.termos: false});

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
  bool? valideMes = false;
  bool? valideCPF = false;
  bool? valideEmail = false;
  bool? valideCelular = false;
  bool? valideNome = false;
  FocusNode nomeFocus = new FocusNode();
  FocusNode emailFocus = new FocusNode();
  FocusNode cpfFocus = FocusNode();
  FocusNode celularFocus = FocusNode();
   FocusNode mesFocus = new FocusNode();
   bool? bisexto = false ;
   int? intDias = 0;
   int? intMes = 0;
   int? intAno = 0;

   String? dia= "";
   String? ano= "";
   String? mes= "";

  String? teste = "";

  bool cancelar = false;

  @override
  void initState() {
    Future.delayed(new Duration(milliseconds: 0), () {
      setState(() {
        cancelar = true;
      });
    });
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
          middle: new Text(
            "CADASTRO USUÁRIO",
            style: MainStyle.get(context).titleStyleText,
          ),
          leading: Align(
            widthFactor: 0.8,
            alignment: Alignment.center,
            child: new GestureDetector(
              child: (cancelar == false)
                  ? new Text(
                      "",
                      style: new TextStyle(color: Colors.transparent),
                    )
                  : Text(
                      'Cancelar',
                      style: new TextStyle(
                          color: Color(0xffE53629),
                          fontSize:
                              MainStyle.get(context).fontSizeLeadinCancelar),
                    ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          trailing: Align(
            widthFactor: 0.8,
            alignment: Alignment.center,
            child: (widget.termos == false)
                ? new Text(
                    "",
                    style: new TextStyle(color: Colors.transparent),
                  )
                : new GestureDetector(
                    child: Text(
                      'Cadastrar',
                      style: new TextStyle(
                          color: Color(0xff1F8782),
                          fontSize:
                              MainStyle.get(context).fontSizeLeadinCancelar),
                    ),
                    onTap: (){
                      if(widget.onPressed != null){
                        widget.onPressed!();
                      }
                    },
                  ),
          ),
        ),
        body: _body());
  }

  Widget _body() {
    return new Column(
      children: <Widget>[
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
          child: new Text("DADOS PESSOAIS",
              style: MainStyle.get(context).mainStyleTextTitle),
        ),
        new Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: new Column(
            children: <Widget>[
              new Container(
                color: Colors.white,
                child: GestureDetector(
                  //NOME COMPLETO
                  onTap: () {
                    FocusScope.of(context).requestFocus(nomeFocus);
                  },
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
                                  style: MainStyle.get(context)
                                      .mainStyleTextBaseLine),
                            ),
                          ),
                          new Expanded(
                            flex: 7,
                            child: new Container(
                              margin:
                                  const EdgeInsets.only(left: 8.0, right: 16.0),
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
                                style: MainStyle.get(context)
                                    .mainStyleTextBaseLineInput,
                                decoration: InputDecoration(
                                    hintText: "Nome Completo",
                                    hintStyle: MainStyle.get(context)
                                        .mainStyleTextBaseLineHint),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                //CPF
                color: Colors.white,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(cpfFocus),
                  child: Column(
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
                                style: MainStyle.get(context)
                                    .mainStyleTextBaseLine,
                              ),
                            ),
                          ),
                          new Expanded(
                            flex: 7,
                            child: new Container(
                              margin:
                                  const EdgeInsets.only(left: 8.0, right: 16.0),
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
                                style: MainStyle.get(context)
                                    .mainStyleTextBaseLineInput,
                                decoration: InputDecoration(
                                    isDense: false,
                                    hintText: "*** . *** . *** - **",
                                    hintStyle: MainStyle.get(context)
                                        .mainStyleTextBaseLineHint),
                                inputFormatters: [
                                  MaskedTextInputFormatterShifter(
                                      maskONE: "XXX.XXX.XXX-XX",
                                      maskTWO: "XXX.XXX.XXX-XX")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                //CELULAR
                color: Colors.white,
                child: GestureDetector(
                  onTap: () =>
                      FocusScope.of(context).requestFocus(celularFocus),
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
                                  style: MainStyle.get(context)
                                      .mainStyleTextBaseLine),
                            ),
                          ),
                          new Expanded(
                            flex: 7,
                            child: new Container(
                              margin:
                                  const EdgeInsets.only(left: 8.0, right: 16.0),
                              child: new TextField(
                                keyboardAppearance: Brightness.light,
                                onSubmitted: (term) {
                                  _fieldFocusChange(
                                      context, celularFocus, emailFocus);
                                },
                                onChanged: (text) {
                                  countCelular = 0;
                                  if (text.length == 16) {
                                    _fieldFocusChange(
                                        context, celularFocus, emailFocus);
                                  }
                                },
                                controller: widget.controllerCelular,
                                focusNode: celularFocus,
                                keyboardType: TextInputType.number,
                                cursorColor: Color(0xFF2BBAB4),
                                style: MainStyle.get(context)
                                    .mainStyleTextBaseLineInput,
                                decoration: InputDecoration(
                                    hintText: "( ** ) 9 **** - ****",
                                    hintStyle: MainStyle.get(context)
                                        .mainStyleTextBaseLineHint),
                                inputFormatters: [
                                  MaskTextInputFormatter(
                                      mask: "(##) # ####-####",
                                      filter: {"#": RegExp(r'[0-9]')}),
                                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                //E-MAIL
                color: Colors.white,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(emailFocus),
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Expanded(
                              flex: 3,
                              child: new Container(
                                padding: const EdgeInsets.only(
                                    top: 12.0, bottom: 12.0, left: 16.0),
                                child: new Text("E-mail",
                                    style: MainStyle.get(context)
                                        .mainStyleTextBaseLine),
                              )),
                          new Expanded(
                            flex: 7,
                            child: new Container(
                              margin:
                                  const EdgeInsets.only(left: 8.0, right: 16.0),
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
                                style: MainStyle.get(context)
                                    .mainStyleTextBaseLineInput,
                                decoration: InputDecoration(
                                    hintText: "email@email.com.br",
                                    hintStyle: MainStyle.get(context)
                                        .mainStyleTextBaseLineHint),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                color: Colors.white,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(mesFocus),
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Expanded(
                            flex: 3,
                            child: new Container(
                              padding: const EdgeInsets.only(
                                  top: 12.0, bottom: 12.0, left: 16.0),
                              child: new Text("Data Nascimento",
                                  style: MainStyle.get(context)
                                      .mainStyleTextBaseLine),
                            ),
                          ),
                          new Expanded(
                            flex: 7,
                            child: new Container(
                              margin:
                                  const EdgeInsets.only(left: 8.0, right: 16.0),
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
                                style: MainStyle.get(context)
                                    .mainStyleTextBaseLineInput,
                                decoration: InputDecoration(
                                    hintText: "dd / mm / aaaa",
                                    hintStyle: MainStyle.get(context)
                                        .mainStyleTextBaseLineHint),
                                inputFormatters: [
                                  MaskedTextInputFormatterShifter(
                                      maskONE: "XX/XX/XXXX",
                                      maskTWO: "XX/XX/XXXX"),
                                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        (widget.possuiCPF == true)
            ? new Container(
                margin: EdgeInsets.only(top: 5.0),
                alignment: Alignment.centerRight,
                child: new ZCheckCPF(),
              )
            : new Container(),
        new Container(
          padding: EdgeInsets.only(
              left: 15.0,
              bottom: 15.0,
              top: (widget.possuiCPF == true) ? 8 : 15),
          alignment: Alignment.centerLeft,
          child: new Text(
            "SEGURANÇA",
            style: MainStyle.get(context).mainStyleTextTitle,
          ),
        ),
        new ZPinSenha(
          onChange: (text) {
            widget.controllerSenha!.text = text;
          },
          context: context,
          numeroQuadrados: 4,
          zTipos: ZTipoSenha.isSenha,
        ),
        new ZPinSenha(
          onChange: (text) {
            widget.controllerRepetirSenha!.text = text;
          },
          context: context,
          numeroQuadrados: 4,
          zTipos: ZTipoSenha.isRepetirSenha,
        ),
        new Container(
          margin: const EdgeInsets.only(top: 10),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Material(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: new Row(
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.termos = !widget.termos!;
                        });
                      },
                      child: new Container(
                        margin: const EdgeInsets.all(2),
                        //gesture aqui
                        decoration: BoxDecoration(
                            color: (widget.termos == false)
                                ? Colors.white
                                : Color(0xff2BB9B4),
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.6)),
                            shape: BoxShape.circle),
                        height: 25.0,
                        width: 25.0,
                        child: new AnimatedSize(
                          duration: Duration(milliseconds: 5000),
                          curve: Curves.fastOutSlowIn,
                          vsync: this,
                          child: new Icon(Icons.check,
                              color: Colors.white,
                              size: (widget.termos == true) ? 20.0 : 0.0),
                        ),
                      ),
                    ),
                    new GestureDetector(
                      onTap: (){
                        if(widget.onTapTermosUso != null){
                          widget.onTapTermosUso!();
                        }
                      },
                      child: new Container(
                        margin: EdgeInsets.only(
                            top: 4.0, bottom: 4, right: 12, left: 16),
                        child: new Text(
                          "ACEITO OS TERMOS DE USO",
                          style: new TextStyle(
                              color: Color(0xff2bbab4),
                              fontSize: MainStyle.get(context).fontSizeTermos,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        /*   new Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 20.0, top: 40),
            child: (widget.termos == false)
                ? ZButton(
                    color: Colors.grey,
                    padding: EdgeInsets.only(
                        top: 12.0, bottom: 12.0, right: 40.0, left: 40.0),
                    zButtonType: ZButtonType.isContained,
                    text: "CADASTRAR USUÁRIO",
                    onPressed: () {},
                  )
                : ZButton(
                    padding: EdgeInsets.only(
                        top: 12.0, bottom: 12.0, right: 40.0, left: 40.0),
                    zButtonType: ZButtonType.isContained,
                    text: "CADASTRAR USUÁRIO",
                    onPressed: widget.onPressed,
                  )
        ),*/
      ],
    );
  }

  Widget titulo() {
    return new Material(
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.7)))),
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0),
        child: new Text("CADASTRO DE USUÁRIO",
            style: MainStyle.get(context).titleStyleText),
      ),
    );
  }

  void validaMes() {
    dia = widget.controllerData!.text.substring(0, 2);
    intDias = int.parse(dia!);

    mes = widget.controllerData!.text.substring(3, 5);
    intMes = int.parse(mes!);

    ano = widget.controllerData!.text.substring(6, 10);
    intAno = int.parse(ano!);

    if ((intAno! % 4 == 0 && intAno! % 100 != 0) || intAno! % 400 == 0) {
      bisexto = true;
    } else {
      bisexto = false;
    }

    if (widget.controllerData!.text.length == 10) {
      if (intMes! < 13 && intDias! < 32 && intAno! < 2004 && intAno! > 1901) {
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
          if (intDias! > 31) {
            showAlertDialogNew(
                "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
          } else {
            valideMes = true;
          }
        } else if (intMes == 04 ||
            intMes == 06 ||
            intMes == 09 ||
            intMes == 11) {
          if (intDias! > 30) {
            showAlertDialogNew(
                "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
          } else {
            valideMes = true;
          }
        } else {
          if (bisexto == true) {
            if (intDias! > 29) {
              showAlertDialogNew(
                  "Dia Inválido!", "Insira um valor de dia entre 01 e 28.");
            } else {
              valideMes = true;
            }
          } else {
            if (intDias! > 28) {
              showAlertDialogNew(
                  "Dia Inválido!", "Insira um valor de dia entre 01 e 28.");
            } else {
              valideMes = true;
            }
          }
        }
      } else if (intMes! > 12 && intDias! < 32 && intAno! < 2004) {
        showAlertDialogNew(
            "Mês Inválido!", "Insira um valor de mês entre 01 e 12.");
      } else if (intMes! < 13 && intDias! > 32 && intAno! < 2004) {
        showAlertDialogNew(
            "Dia Inválido!", "Insira um valor de dia entre 01 e 31.");
      } else if (intMes! < 13 && intDias! < 32 && intAno! > 2004) {
        showAlertDialogNew(
            "Ano Inválido!", "Insira um valor de ano entre 1901 e 2004.");
      } else if (intAno! < 1901) {
        showAlertDialogNew(
            "Ano Inválido!", "Insira um valor de ano entre 1901 e 2004.");
      } else if (intMes! > 12 && intDias! < 32 && intAno! > 2004) {
        showAlertDialogNew("Mês e Ano Inválido!",
            "Insira um valor de mês entre 01 e 12 e um ano entre 1901 e 2004.");
      } else if (intMes! > 12 && intDias! > 32 && intAno! < 2004) {
        showAlertDialogNew("Mês e Dia Inválido!",
            "Insira um valor de mês entre 01 e 12 e dia entre 01 e 31.");
      } else if (intMes! < 13 && intDias! > 32 && intAno! > 2004) {
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
                ),
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
                        color: const Color(0xff707070), fontSize: 13),
                  ),
                ),
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
                  child: Center(
                    child: new Text(
                      "ENTENDI",
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              margin: const EdgeInsets.only(bottom: 8),
            ),
          ],
        ),
      ),
    );
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
    if (widget.controllerData!.text.length < 10 &&
        widget.controllerData!.text.length >= 1) {
      showAlertDialogNew("Data Inválida!",
          "Por Favor, termine de digitar sua data de nascimento");
    }
  }

  void _valideNome() {
    if (widget.controllerNome!.text.split(' ').length < 2 &&
        widget.controllerNome!.text.length >= 1) {
      valideNome = false;
      showAlertDialogNew("Nome Inválido!", "Por Favor insira o nome completo.");
    } else {
      valideNome = true;
    }
  }

  void _validarCPF() {
    if (!CPFValidator.isValid(widget.controllerCPF!.text) &&
        widget.controllerCPF!.text.length >= 1) {
      valideCPF = false;
      showAlertDialogNew("CPF Inválido!", "Por Favor insira um CPF válido.");
    } else {
      valideCPF = true;
    }
  }

  void _validarCelular() {
    if (widget.controllerCelular!.text.length < 16 &&
        widget.controllerCelular!.text.length >= 1) {
      valideCelular = false;
      showAlertDialogNew(
          "Celular Inválido!", "Por Favor, Termine de digitar o seu celular.");
    } else {
      valideCelular = true;
    }
  }

  void _validarEmail() {
    if (!EmailValidator.validate(widget.controllerEmail!.text.trim()) &&
        widget.controllerEmail!.text.length >= 1) {
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

import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputEmail extends StatefulWidget {
  final Key key;
  FocusNode emailFocus;
  var controllerEmail = new TextEditingController();
  FocusNode proximoFocus;
  String email;
  bool valideEmail;

  ZInputEmail(
      {this.key,
        @required this.emailFocus,
        @required this.controllerEmail,
        @required this.proximoFocus})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ZInputDataNascimentoState();
}

class ZInputDataNascimentoState extends State<ZInputEmail> {
  int emailCount = 1;
  DialogUtils _dialogUtils;
  String data;
  bool validaEmail;


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
        "E-mail:",
        TextInputType.number,
            () {
          FocusScope.of(context).requestFocus(widget.emailFocus);
        },
        widget.emailFocus,
        widget.controllerEmail,
        widget.proximoFocus,
            (text) {
          data = text;
          emailCount = 0;
          if (data.length == 10) {
            _fieldFocusChange(context, widget.emailFocus, widget.proximoFocus);
          }
        },
        true,
        textMask: "XX/XX/XXXX",
        hintText: "email@exemplo.com");
  }

  void initNome() {
    widget.emailFocus.addListener(() {
      if (!widget.emailFocus.hasFocus && emailCount == 0 && data != "") {
        _validarEmail();
      }
    });
  }

  void _validarEmail()  {
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

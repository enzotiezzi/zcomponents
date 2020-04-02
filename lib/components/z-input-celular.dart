import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputCelular extends StatefulWidget {

  final Key key;
  FocusNode celularFocus;
  var controllerCelular = new TextEditingController();
  FocusNode proximoFocus;

  ZInputCelular(
      {this.key,
        @required this.celularFocus,
        @required this.controllerCelular,
        this.proximoFocus,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ZInputCelularState();
}

class ZInputCelularState extends State<ZInputCelular> {

  int countCelular = 0;
  DialogUtils _dialogUtils;
  String celular;
  bool valideCelular;

  @override
  void initState() {
    _dialogUtils = new DialogUtils(context);
    initCelular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.styleTextInput(
        context,
        "Celular:",
        TextInputType.number,
            () {
          FocusScope.of(context).requestFocus(widget.celularFocus);
        },
        widget.celularFocus,
        widget.controllerCelular,
        widget.proximoFocus,
            (text) {
              celular = text;
              countCelular = 0;
              if (celular.length == 15) {
                _fieldFocusChange(context, widget.celularFocus,
                    widget.proximoFocus);
          }
        },true,

        textMask: "(XX) X XXXXX-XXXX",
        hintText: "( ** ) 9 **** - ****");
  }

  void initCelular() {
    widget.celularFocus.addListener(() {
      if (!widget.celularFocus.hasFocus &&
          countCelular == 0 &&
          celular != "") {
        _validarCelular();
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
  void _validarCelular() {
    if (celular == null) {
      valideCelular = false;
      _dialogUtils.showAlertDialogNewAviso(
          "Celular Inválido!", "Por Favor, digitar o seu celular.");
    } else if (celular.length < 16) {
      valideCelular = false;
      _dialogUtils.showAlertDialogNewAviso(
          "Celular Inválido!", "Por Favor, Termine de digitar o seu celular.");
    } else if (celular.length == 16) {
      var splitCelular = celular.split(" ");

      if (splitCelular[1] == "9") {
        valideCelular = true;
      } else {
        valideCelular = false;
        _dialogUtils.showAlertDialogNewAviso("Celular Inválido!",
            "Os celulares no Brasil devem começar com 9. Por Favor digite novamente o seu celular.");
      }
    }
  }
}

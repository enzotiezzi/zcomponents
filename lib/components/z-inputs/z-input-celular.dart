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
  ValueChanged<String> onChange;
  void Function(bool) validacao;
  bool enabled;

  ZInputCelular(
      {this.key,
      this.onChange,
      @required this.celularFocus,
      @required this.controllerCelular,
      this.proximoFocus,
      this.validacao,
      this.enabled})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZInputCelularState();
}

class _ZInputCelularState extends State<ZInputCelular> {
  int countCelular = 0;
  DialogUtils _dialogUtils;
  String celular = "";

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
          if (widget.onChange != null) widget.onChange(text);

          celular = text;
          countCelular = 0;
          if (celular.length == 15) {
            _fieldFocusChange(
                context, widget.celularFocus, widget.proximoFocus);
          }
        },
        true,
        textMask: "(##) #####-####",
        hintText: "( ** ) 9 **** - ****",enabled: widget.enabled);
  }

  void initCelular() {
    widget.celularFocus.addListener(() {
      if (!widget.celularFocus.hasFocus && countCelular == 0 && celular != "") {
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
    if (celular.length < 15 && celular != "") {
      _dialogUtils.showAlertDialogNewAviso(
          "Celular Inválido!", "Por Favor, Termine de digitar o seu celular.");
      if (widget.validacao != null) widget.validacao(false);
    } else {
      if (widget.validacao != null) widget.validacao(true);
    }
  }
}

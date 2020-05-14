import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/config/z-tipo-senha.dart';
import 'package:z_components/styles/main-style.dart';
import '../z-pin-senha.dart';
import '../z-progress-dialog.dart';

class ConfirmarSenha {
  String token;
  String cpf;
  BuildContext context;

  ConfirmarSenha({@required this.token,@required this.cpf, @required this.context});

  Future<bool> dialogConfirmarSenha() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ZAlertDialog(
        zDialog: ZDialog.normal,
        child: new Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 10.0,
                  ),
                  width: MediaQuery.of(context).size.width * 0.75,
                  margin: const EdgeInsets.only(top: 16, bottom: 10),
                  child: new Text(
                    "Confirme seu pin",
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            new Container(alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: new Container(alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 8),
                color: Colors.white,
                padding: EdgeInsets.only(left: 15.0, top: 8.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(color: Colors.transparent,height: 1,width: 50.0,),
                    new Expanded(
                        child: new Container(alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 20.0, top: 8),
                            child: new PinCodeTextField(
                              highlightColor: const Color(0xff2BBAB4),
                              highlight: true,
                              defaultBorderColor: const Color(0xffC7C7CC),
                              hasTextBorderColor: const Color(0xffC7C7CC),
                              maxLength: 4,
                              pinBoxHeight: MainStyle.get(context).sizePin,
                              pinBoxWidth: MainStyle.get(context).sizePin,
                              maskCharacter: "*",
                              pinBoxRadius: 6,
                              onDone: (text) async {
                                await _verificarPin(text);
                              },
                              pinTextAnimatedSwitcherTransition:
                                  ProvidedPinBoxTextAnimation.scalingTransition,
                              pinTextAnimatedSwitcherDuration:
                                  Duration(milliseconds: 150),
                              pinTextStyle: new TextStyle(fontSize: 22),
                              hideCharacter: true,
                            ))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verificarPin(String text) {
    var service;
    if (service != null) {
      Navigator.of(context).pop(true);
    } else {
      Navigator.of(context).pop(false);
    }
  }
}

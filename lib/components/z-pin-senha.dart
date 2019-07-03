import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:z_components/config/z-tipo-senha.dart';

class ZPinSenha extends StatelessWidget {
  Widget _zPinSenha;

  final Key key;
  final BuildContext context;
  final ZTipoSenha zTipos;
  String change;
  int numeroQuadrados;

  ZPinSenha(
      {this.key,
      this.context,
      this.zTipos = ZTipoSenha.isSenha,
      this.change,
      this.numeroQuadrados})
      : super(key: key) {
    switch (zTipos) {
      case ZTipoSenha.isSenha:
        _zPinSenha = new Container(

          margin: const EdgeInsets.only(bottom: 8),
          color: Colors.white,
          padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 8.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: 100,
                child: new Text(
                  "Senha",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              new Expanded(
                  child: new Container(
                      margin: EdgeInsets.only(right: 20.0),

                      child: new PinCodeTextField(
                          highlightColor: const Color(0xff2BBAB4),
                          highlight: true,
                          defaultBorderColor: const Color(0xffC7C7CC),
                          hasTextBorderColor: const Color(0xffC7C7CC),
                          isCupertino: true,
                          maxLength: numeroQuadrados,
                          pinBoxHeight: 40.0,
                          pinBoxWidth: 40.0,
                          maskCharacter: "*",
                          pinTextAnimatedSwitcherTransition:
                              ProvidedPinBoxTextAnimation.scalingTransition,
                          pinTextAnimatedSwitcherDuration:
                              Duration(milliseconds: 150),
                          pinTextStyle: new TextStyle(fontSize: 22),
                          hideCharacter: true,
                          onTextChanged: (text) {
                            change = text;
                          }))),
            ],
          ),
        );
        break;
      case ZTipoSenha.isRepetirSenha:
        _zPinSenha = new Container(
          margin: const EdgeInsets.only(bottom: 8),
          color: Colors.white,
          padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 8.0),

          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: 100,
                child: new Text(
                  "Repetir Senha",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              new Expanded(
                  child: new Container(
                      margin: EdgeInsets.only(right: 20.0),
                      child: new PinCodeTextField(
                          highlightColor: const Color(0xff2BBAB4),
                          highlight: true,
                          defaultBorderColor: const Color(0xffC7C7CC),
                          hasTextBorderColor: const Color(0xffC7C7CC),
                          isCupertino: true,
                          maxLength: numeroQuadrados,
                          pinBoxHeight: 40.0,
                          pinBoxWidth: 40.0,
                          maskCharacter: "*",
                          pinTextAnimatedSwitcherTransition:
                              ProvidedPinBoxTextAnimation.scalingTransition,
                          pinTextAnimatedSwitcherDuration:
                              Duration(milliseconds: 150),
                          pinTextStyle: new TextStyle(fontSize: 22),
                          hideCharacter: true,
                          onTextChanged: (text) {
                            change = text;
                          }))),
            ],
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _zPinSenha;
  }
}

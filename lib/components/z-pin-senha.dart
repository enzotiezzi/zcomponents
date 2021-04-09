import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:z_components/config/z-tipo-senha.dart';
import 'package:z_components/styles/main-style.dart';

class ZPinSenha extends StatelessWidget {
  Widget _zPinSenha;

  final Key key;
  final BuildContext context;
  final ZTipoSenha zTipos;
  final Function(String) onChange;
  int numeroQuadrados;
  final String titulo;

  ZPinSenha(
      {this.key,
      this.context,
      this.zTipos = ZTipoSenha.isSenha,
      this.onChange,
      this.numeroQuadrados,
      this.titulo})
      : super(key: key) {
    switch (zTipos) {
      case ZTipoSenha.isSenha:
        _zPinSenha = new Container(
          margin: const EdgeInsets.only(bottom: 8),
          color: Colors.white,
          padding: EdgeInsets.only(left: 15.0, top: 8.0,bottom: 8),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: 100,
                child: new Text(
                  titulo ?? "Senha",
                  style: MainStyle.get(context).mainStyleTextBaseLine,
                ),
              ),
              new Expanded(
                  child: new Container(
                      margin: EdgeInsets.only(right: 20.0, top: 8,bottom: 8),
                      child: new PinCodeTextField(
                        highlightColor: const Color(0xff2BBAB4),
                        highlight: true,
                        defaultBorderColor: const Color(0xffC7C7CC),
                        hasTextBorderColor: const Color(0xffC7C7CC),
                        maxLength: numeroQuadrados,
                        pinBoxHeight: MainStyle.get(context).sizePin,
                        pinBoxWidth: MainStyle.get(context).sizePin,
                        maskCharacter: "*",
                        pinBoxRadius: 6,
                        onDone: onChange,
                        pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration:
                            Duration(milliseconds: 150),
                        pinTextStyle: new TextStyle(fontSize: 22),
                        hideCharacter: true,
                      ))),
            ],
          ),
        );
        break;
      case ZTipoSenha.isRepetirSenha:
        _zPinSenha = new Container(
          margin: const EdgeInsets.only(bottom: 8),
          color: Colors.white,
          padding: EdgeInsets.only(left: 15.0, top: 8.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: 100,
                child: new Text(
                  titulo ?? "Repetir \nSenha",
                  style: MainStyle.get(context).mainStyleTextBaseLine,
                ),
              ),
              new Expanded(
                  child: new Container(
                      margin: EdgeInsets.only(right: 20.0, top: 8),
                      child: new PinCodeTextField(
                        highlightColor: const Color(0xff2BBAB4),
                        highlight: true,
                        defaultBorderColor: const Color(0xffC7C7CC),
                        hasTextBorderColor: const Color(0xffC7C7CC),
                        maxLength: numeroQuadrados,
                        pinBoxHeight: MainStyle.get(context).sizePin,
                        pinBoxWidth: MainStyle.get(context).sizePin,
                        maskCharacter: "*",
                        pinBoxRadius: 6,
                        onDone: onChange,
                        pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration:
                            Duration(milliseconds: 150),
                        pinTextStyle: new TextStyle(fontSize: 22),
                        hideCharacter: true,
                      ))),
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

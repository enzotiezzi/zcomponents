import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/styles/media-query.dart';

class MainStyle {
  static const Color APP_THEME = Colors.amber;

  static _MainStyle get(BuildContext context) => _MainStyle(context: context);
}

class _MainStyle {
  BuildContext context;

  _MainStyle({this.context});

  TextStyle get mainStyleTextBaseLine {
    return new TextStyle(
        color: Color(0xFF999999),
        letterSpacing: -0.24,
        fontWeight: FontWeight.w500,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get mainStyleTextBaseLineHint {
    return new TextStyle(
        color: Color(0xffc7c7c7),
        letterSpacing: -0.24,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get mainStyleTextBaseLineInput {
    return new TextStyle(
        color: Colors.black,
        letterSpacing: -0.24,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get mainStyleText {
    return new TextStyle(
        color: MediaQuerySize.get(context).color,
        letterSpacing: -0.24,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get mainStyleTextTitle {
    return new TextStyle(
        color: MediaQuerySize.get(context).color,
        letterSpacing: -0.24,
        fontWeight: FontWeight.w500,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get mainStyleTextWhite {
    return new TextStyle(
        color: Colors.white,
        letterSpacing: -0.24,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get styleTextWhiteUnderline {
    return new TextStyle(
        color: Colors.white,
        letterSpacing: -0.24,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuerySize.get(context).fontSize);
  }

  TextStyle get titleStyleText {
    return new TextStyle(
        color: MediaQuerySize.get(context).color,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.24,
        fontSize: MediaQuerySize.get(context).tittleFontSize);
  }

  TextStyle get styleButtonText {
    return new TextStyle(
        color: MediaQuerySize.get(context).color,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.07,
        fontSize: MediaQuerySize.get(context).fontSizeButton);
  }

  TextStyle get styleButtonTextWhite {
    return new TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.07,
        fontSize: MediaQuerySize.get(context).fontSizeButton);
  }

  TextStyle get styleInputText {
    return new TextStyle(
        color: MediaQuerySize.get(context).color,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuerySize.get(context).tittleFontSize);
  }

  TextStyle get styleHintTextGrey {
    return new TextStyle(
        color: Color(0xffC7C7CC),
        fontSize: MediaQuerySize.get(context).fontSizeButton);
  }

  TextStyle get styleTittleDialog {
    return new TextStyle(
        color: MediaQuerySize.get(context).color,
        fontWeight: FontWeight.w700,
        fontSize: MediaQuerySize.get(context).styleTittleDialogSize);
  }

  double get marginRightLeft {
    return 16.0;
  }

  Color get color {
    return Color(0xff999999);
  }

  Color get backgroundColor {
    return Color(0xffff0f0f0);
  }

  double get fontSizeEntradaSaida {
    return MediaQuerySize.get(context).fontSize;
  }

  double get sizePin {
    return MediaQuerySize.get(context).sizePin;
  }

  double get fontSizeTermos {
    return MediaQuerySize.get(context).fontSizeTermos;
  }

  double get fontSizeLeadinCancelar {
    return MediaQuerySize.get(context).fontSizeLeadinCancelar;
  }

  double get subTitleFontSize {
    return 12.0;
  }
}

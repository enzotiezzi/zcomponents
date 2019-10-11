import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/styles/media-query-parameters.dart';


class MediaQuerySize {

  static _MediaQuery get(BuildContext context) => _MediaQuery(context: context);
}

class _MediaQuery {
  BuildContext context;
  var width;
  var height;

  _MediaQuery({this.context}){
    width =  MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  double get fontSize {
    return Paramenters(width: width,height: height).mainFontSize;
  }

  double get tittleFontSize {
    return Paramenters(width: width,height: height).titleFontSize;
  }
  double get styleTittleDialogSize {
    return Paramenters(width: width,height: height).tittleFontSizeDialog;
  }
  double get fontSizeButton {
    return Paramenters(width: width,height: height).fontSizeButton;
  }

  double get subTitleFontSize {
    return Paramenters(width: width,height: height).subTitleFontSize;
  }

  double get sizePin{
    return Paramenters(width: width,height: height).sizePin;
  }

  double get  fontSizeTermos{
    return Paramenters(width: width,height: height).fontSizeTermos;
  }

  double get  fontSizeLeadinCancelar{
    return Paramenters(width: width,height: height).fontSizeLeadinCancelar;
  }

  Color get color {
    return Paramenters(width: width,height: height).color;
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Paramenters {
  double width;
  double height;

  Paramenters({this.width, this.height});

  int xs = 320;
  int x = 600;

  double get mainFontSize {
    double fontSize = 0;

    if (width <= xs) {
      fontSize = 12;
    } else if (width > xs && width <= x) {
      fontSize = 14;
    }
    return fontSize;
  }

  double get fontSizeButton {
    double fontSize = 0;

    if (width <= xs) {
      fontSize = 16;
    } else if (width > xs && width <= x) {
      fontSize = 20;
    }
    return fontSize;
  }

  double get subTitleFontSize {
    double fontSize = 0;

    if (width <= xs) {
      fontSize = 11;
    } else if (width > xs && width <= x) {
      fontSize = 12;
    }
    return fontSize;
  }

  double get titleFontSize {
    double fontSize = 0;

    if (width <= xs) {
      fontSize = 15;
    } else if (width > xs && width <= x) {
      fontSize = 18;
    }
    return fontSize;
  }

  double get sizePin {
    double size = 0;

    if (width <= xs) {
      size = 36;
    } else if (width > xs && width <= x) {
      size = 40;
    }
    return size;
  }

  double get fontSizeTermos {
    double size = 0;

    if (width <= xs) {
      size = 13;
    } else if (width > xs && width <= x) {
      size = 14;
    }
    return size;
  }

  double get fontSizeLeadinCancelar {
    double size = 0;

    if (width <= xs) {
      size = 12;
    } else if (width > xs && width <= x) {
      size = 15;
    }
    return size;
  }

  Color get color {
    Color color = Colors.black;

    return color;
  }

  Color get backgroundColor {
    var color = Color(0xffff0f0f0);

    return color;
  }

  double get tittleFontSizeDialog {
    double fontSize = 0;

    if (width <= xs) {
      fontSize = 13;
    } else if (width > xs && width <= x) {
      fontSize = 16;
    }
    return fontSize;
  }
}

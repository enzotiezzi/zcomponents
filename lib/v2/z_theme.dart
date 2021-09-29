import 'package:flutter/material.dart';

class ZTheme {
  static Map<ZUIState, Color> colorStateMap = {
    ZUIState.ACTIVE: Colors.grey,
    ZUIState.WARNING: warningColor,
    ZUIState.ERROR: errorColor,
    ZUIState.FOCUS: focusColor
  };

  static Color warningColor = const Color(0xffffd800);
  static Color successColor = const Color(0xff23e300);
  static Color errorColor = const Color(0xffB00020);
  static Color focusColor = const Color(0xff2bbab4);
}

enum ZUIState{
  ACTIVE,
  WARNING,
  ERROR,
  FOCUS
}
import 'package:flutter/material.dart';

class ZTheme {
  static Color primaryColor = const Color(0xff2bbab4);

  static Map<ZUIState, Color> colorStateMap = {
    ZUIState.ACTIVE: Colors.grey,
    ZUIState.WARNING: warningColor,
    ZUIState.ERROR: errorColor,
    ZUIState.FOCUSED: focusColor
  };

  // COLOR
  static Color warningColor = const Color(0xffffd800);
  static Color successColor = const Color(0xff23e300);
  static Color errorColor = const Color(0xffB00020);
  static Color focusColor = const Color(0xff2bbab4);
}

enum ZUIState {
  // FEEDBACK
  ERROR,
  WARNING,
  SUCCESS,
  INFORMATION,
  FOCUSED,
  ACTIVE,
}

///////////////////////////////

enum ZControlState{
  ENABLED,
  DISABLED,
  READONLY,
}

enum ZInteractiveState{
  REGULAR,
  ACTIVE,
  //HOVER,  web only
  FOCUSED,
  FILLED,
  PRESSED,
  CHECKED,
  UNCHECKED
}

enum ZFeedbackState {
  NONE,
  ERROR,
  WARNING,
  SUCCESS,
  INFORMATION,
  LOADING
}
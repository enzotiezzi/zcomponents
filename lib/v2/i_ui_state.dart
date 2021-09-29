import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:z_components/v2/z_theme.dart';

mixin UIFormState<T extends StatefulWidget> on State<T> {
  ZUIState currentUIState = ZUIState.ACTIVE;

  Color currentColor = ZTheme.colorStateMap[ZUIState.ACTIVE];

  void setUIState(ZUIState zuiState){
    currentUIState = zuiState;

    Color newColor;

    switch(currentUIState) {
      case ZUIState.ACTIVE:
        newColor = Colors.grey;
        break;
      case ZUIState.WARNING:
        newColor = ZTheme.warningColor;
        break;
      case ZUIState.ERROR:
        newColor = ZTheme.errorColor;
        break;
      case ZUIState.FOCUS:
        newColor = ZTheme.focusColor;
        break;
    }

    if(mounted)
      setState(() {
        currentColor = newColor;
      });
  }
}
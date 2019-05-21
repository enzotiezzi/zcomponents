import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ZButton extends StatelessWidget {
  Key key;
  Widget zButton;
  double minSize;
  VoidCallback onPressed;
  ValueChanged<bool> onHighlightChanged;
  ButtonTextTheme textTheme;
  Color textColor;
  Color disabledTextColor;
  Color color;
  Color disabledColor;
  EdgeInsetsGeometry padding;
  Color highlightColor;
  Color splashColor;
  double elevation;
  double highlightElevation;
  double disabledElevation;
  Widget child;
  ShapeBorder shape;
  BorderRadius borderRadius;
  double pressedOpacity;

  ZButton({
    Key key,
    @required this.onPressed,
    this.onHighlightChanged,
    this.textTheme,
    this.textColor,
    this.padding,
    this.disabledTextColor,
    this.color = Colors.teal,
    this.disabledColor,
    this.highlightColor,
    this.splashColor,
    this.elevation,
    this.highlightElevation,
    this.disabledElevation,
    this.minSize = 44.0,
    this.pressedOpacity = 0.1,
    this.child,
    this.shape,
    this.borderRadius,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0) {
    if (Platform.isAndroid) {
      zButton = new RaisedButton(
        onPressed: this.onPressed,
        child: this.child,
        color: this.color,
        shape: this.shape,
        elevation: this.elevation,
        padding: this.padding,
        disabledElevation: this.disabledElevation,
        highlightElevation: this.highlightElevation,
        splashColor: this.splashColor,
        disabledColor: this.disabledColor,
        key: key,
      );
    } else {
      zButton = new CupertinoButton(
        onPressed: this.onPressed,
        child: this.child,
        color: this.color,
        padding: this.padding,
        borderRadius: this.borderRadius,
        disabledColor: this.disabledColor,
        key: key,
        minSize: this.minSize,
        pressedOpacity: this.pressedOpacity,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return zButton;
  }
}

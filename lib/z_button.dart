import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_components/z-platform.dart';

class ZButton extends StatelessWidget {
  Widget _zButton;

  final Key key;
  final double minSize;
  final VoidCallback onPressed;
  final ValueChanged<bool> onHighlightChanged;
  final ButtonTextTheme textTheme;
  final Color textColor;
  final Color disabledTextColor;
  final Color color;
  final Color disabledColor;
  final EdgeInsetsGeometry padding;
  final Color highlightColor;
  final Color splashColor;
  final double elevation;
  final double highlightElevation;
  final double disabledElevation;
  final Widget child;
  final ShapeBorder shape;
  final BorderRadius borderRadius;
  final double pressedOpacity;
  final Brightness colorBrightness;
  final Clip clipBehavior;
  final MaterialTapTargetSize materialTapTargetSize;
  final Duration animationDuration;
  final ZPlatform zPlatform;

  ZButton({
    this.key,
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
    this.materialTapTargetSize,
    this.clipBehavior = Clip.none,
    this.colorBrightness,
    this.animationDuration,
    this.zPlatform = ZPlatform.isPlatform,
  }) : super(key: key) {
    switch (zPlatform) {
      case ZPlatform.isPlatform:
        if (Platform.isAndroid) {
          _zButton = new RaisedButton(
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
            key: this.key,
            materialTapTargetSize: this.materialTapTargetSize,
            clipBehavior: this.clipBehavior,
            textTheme: this.textTheme,
            animationDuration: this.animationDuration,
            colorBrightness: this.colorBrightness,
            disabledTextColor: this.disabledTextColor,
            highlightColor: this.highlightColor,
            onHighlightChanged: this.onHighlightChanged,
            textColor: this.textColor,
          );
        } else {
          _zButton = new CupertinoButton(
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
        break;
      case ZPlatform.isAndroid:
        _zButton = new RaisedButton(
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
          key: this.key,
          materialTapTargetSize: this.materialTapTargetSize,
          clipBehavior: this.clipBehavior,
          textTheme: this.textTheme,
          animationDuration: this.animationDuration,
          colorBrightness: this.colorBrightness,
          disabledTextColor: this.disabledTextColor,
          highlightColor: this.highlightColor,
          onHighlightChanged: this.onHighlightChanged,
          textColor: this.textColor,
        );
        break;
      case ZPlatform.isIOS:
        _zButton = new CupertinoButton(
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
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _zButton;
  }
}

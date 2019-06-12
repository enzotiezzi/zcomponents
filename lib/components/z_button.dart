import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_components/config/z-button-type.dart';
import 'package:z_components/config/z-platform.dart';

class ZButton extends StatelessWidget {
  Widget _zButton;

  final Key key;
  final double minSize;
  final VoidCallback onPressed;
  final String text;
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
  final ShapeBorder shape;
  final BorderRadius borderRadius;
  final double pressedOpacity;
  final Brightness colorBrightness;
  final Clip clipBehavior;
  final MaterialTapTargetSize materialTapTargetSize;
  final Duration animationDuration;
  final ZButtonType zButtonType;

  ZButton({
    this.key,
    @required this.onPressed,
    this.text,
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
    this.shape,
    this.borderRadius,
    this.materialTapTargetSize,
    this.clipBehavior = Clip.none,
    this.colorBrightness,
    this.animationDuration,
    this.zButtonType = ZButtonType.isContained,

  }) : super(key: key) {
    switch (zButtonType) {
      case ZButtonType.isContained:
          _zButton = new RaisedButton(
            onPressed: this.onPressed,
            child: new Text(this.text, style: TextStyle(color: Colors.white),),
            color: const Color(0xff2BBAB4),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
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
      case ZButtonType.isOutlined:
        _zButton = new RaisedButton(
          onPressed: this.onPressed,
          child: new Container(
            padding: EdgeInsets.fromLTRB(20.0, 7.0, 20.0, 7.0),
            child: new Text(this.text,style: TextStyle( color: const Color(0xff2BBAB4), ),),decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(30.0),
              border: Border.all(   color: const Color(0xff2BBAB4),)),),
          color:Colors.transparent,
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          elevation: 0,
          padding: this.padding,
          disabledElevation: this.disabledElevation,
          highlightElevation: 0,
          splashColor: Colors.transparent,
          disabledColor: this.disabledColor,
          key: this.key,
          materialTapTargetSize: this.materialTapTargetSize,
          clipBehavior: this.clipBehavior,
          textTheme: this.textTheme,
          animationDuration: this.animationDuration,
          colorBrightness: this.colorBrightness,
          disabledTextColor: this.disabledTextColor,
          highlightColor: Colors.transparent,
          onHighlightChanged: this.onHighlightChanged,
          textColor: this.textColor,
        );
        break;

    }
  }

  @override
  Widget build(BuildContext context) {
    return _zButton;
  }
}

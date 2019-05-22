import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZLoading extends StatelessWidget {
  Widget zLoading;
  BuildContext context;
  Key key;
  double value;
  Color backgroundColor;
  Animation<Color> valueColor;
  double strokeWidth;
  String semanticsLabel;
  String semanticsValue;
  bool animating;
  double radius;

  ZLoading({
    this.context,
    Key key,
    this.value,
    this.backgroundColor,
    this.valueColor,
    this.strokeWidth = 4.0,
    this.semanticsLabel,
    this.semanticsValue,
    this.animating = true,
    this.radius = 15.0,
  }) {
    if (Platform.isAndroid) {
     zLoading = CircularProgressIndicator(
        key: key,
        value: value,
        backgroundColor: backgroundColor,
        valueColor: valueColor,
        strokeWidth: strokeWidth,
        semanticsLabel: semanticsLabel,
        semanticsValue: semanticsValue,
      );
    } else {
     zLoading = CupertinoActivityIndicator(
        key: key,
        animating: this.animating,
        radius: this.radius,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return zLoading;
  }
}

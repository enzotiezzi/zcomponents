import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/config/z-platform.dart';

class ZLoading extends StatelessWidget {
  Widget _zLoading;

  final BuildContext context;
  final Key key;
  final double value;
  final Color backgroundColor;
  final Animation<Color> valueColor;
  final double strokeWidth;
  final String semanticsLabel;
  final String semanticsValue;
  final bool animating;
  final double radius;
  final ZPlatform zPlatform;
  
  ZLoading({
    this.context,
    this.key,
    this.value,
    this.backgroundColor,
    this.valueColor,
    this.strokeWidth = 4.0,
    this.semanticsLabel,
    this.semanticsValue,
    this.animating = true,
    this.radius = 15.0,
    this.zPlatform = ZPlatform.isPlatform,
  }) : super(key: key) {
    switch (zPlatform) {
      case ZPlatform.isPlatform:
        if (Platform.isAndroid) {
          _zLoading = CircularProgressIndicator(
            key: this.key,
            value: this.value,
            backgroundColor: this.backgroundColor,
            valueColor: this.valueColor,
            strokeWidth: this.strokeWidth,
            semanticsLabel: this.semanticsLabel,
            semanticsValue: this.semanticsValue,
          );
        } else {
          _zLoading = CupertinoActivityIndicator(
            key: this.key,
            animating: this.animating,
            radius: this.radius,
          );
        }
        break;
      case ZPlatform.isAndroid:
        _zLoading = CircularProgressIndicator(
          key: this.key,
          value: this.value,
          backgroundColor: this.backgroundColor,
          valueColor: this.valueColor,
          strokeWidth: this.strokeWidth,
          semanticsLabel: this.semanticsLabel,
          semanticsValue: this.semanticsValue,
        );
        break;
      case ZPlatform.isIOS:
        _zLoading = CupertinoActivityIndicator(
          key: this.key,
          animating: this.animating,
          radius: this.radius,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _zLoading;
  }
}

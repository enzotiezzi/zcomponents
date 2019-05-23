import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:z_components/z-platform.dart';

class ZAlertDialog extends StatelessWidget {
  Widget _zAlertDialog;

  final Key key;
  final Widget title;
  final EdgeInsetsGeometry titlePadding;
  final TextStyle titleTextStyle;
  final Widget content;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle contentTextStyle;
  final List<Widget> actions;
  final Color backgroundColor;
  final double elevation;
  final String semanticLabel;
  final ShapeBorder shape;
  final List<Widget> actionsCupertino;
  final ScrollController scrollController;
  final ScrollController actionScrollController;
  final ZPlatform zPlatform;

  ZAlertDialog({
    this.key,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.content,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.contentTextStyle,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.shape,
    this.actionsCupertino = const <Widget>[],
    this.scrollController,
    this.actionScrollController,
    this.zPlatform = ZPlatform.isPlatform,
  })  : assert(contentPadding != null),
        super(key: key) {
    switch (zPlatform) {
      case ZPlatform.isPlatform:
        if (Platform.isAndroid) {
          _zAlertDialog = AlertDialog(
            backgroundColor: this.backgroundColor,
            shape: this.shape,
            elevation: this.elevation,
            key: this.key,
            title: this.title,
            actions: this.actions,
            titlePadding: this.titlePadding,
            contentPadding: this.contentPadding,
            content: this.content,
            contentTextStyle: this.contentTextStyle,
            semanticLabel: this.semanticLabel,
            titleTextStyle: this.titleTextStyle,
          );
        } else {
          _zAlertDialog = CupertinoAlertDialog(
            actions: this.actions,
            title: this.title,
            content: this.content,
            key: this.key,
            actionScrollController: this.actionScrollController,
            scrollController: this.scrollController,
          );
        }
        break;
      case ZPlatform.isAndroid:
        _zAlertDialog = AlertDialog(
          backgroundColor: this.backgroundColor,
          shape: this.shape,
          elevation: this.elevation,
          key: this.key,
          title: this.title,
          actions: this.actions,
          titlePadding: this.titlePadding,
          contentPadding: this.contentPadding,
          content: this.content,
          contentTextStyle: this.contentTextStyle,
          semanticLabel: this.semanticLabel,
          titleTextStyle: this.titleTextStyle,
        );
        break;
      case ZPlatform.isIOS:
        _zAlertDialog = CupertinoAlertDialog(
          actions: this.actions,
          title: this.title,
          content: this.content,
          key: this.key,
          actionScrollController: this.actionScrollController,
          scrollController: this.scrollController,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _zAlertDialog;
  }
}

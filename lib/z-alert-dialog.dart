import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ZAlertDialog extends StatelessWidget {
  Widget zAlertDialog;
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

  ZAlertDialog({
    Key key,
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
  })  : assert(contentPadding != null),
        assert(actions != null),
        super(key: key){
          if(Platform.isAndroid){
            zAlertDialog = AlertDialog(backgroundColor: this.backgroundColor,
            shape: this.shape,
            elevation: this.elevation,
             key: this.key,
            title: this.title,
            actions: <Widget>[],
            titlePadding: this.titlePadding,
              contentPadding: this.contentPadding,
              content: this.content,
              contentTextStyle: this.contentTextStyle,
              semanticLabel: this.semanticLabel,
              titleTextStyle: this.titleTextStyle,
            );
          }
}

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog();
  }
}

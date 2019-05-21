import 'dart:io';

import 'package:flutter/foundation.dart';
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
        super(key: key) {
    if (Platform.isAndroid) {
      zAlertDialog = AlertDialog(
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
      zAlertDialog = CupertinoAlertDialog(
        actions: this.actions,
        title: this.title,
        content: this.content,
        key: this.key,
        actionScrollController: this.actionScrollController,
        scrollController: this.scrollController,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final List<Widget> children = <Widget>[];
    String label = semanticLabel;

    if (title != null) {
      children.add(Padding(
        padding: titlePadding ??
            EdgeInsets.fromLTRB(24.0, 24.0, 24.0, content == null ? 20.0 : 0.0),
        child: DefaultTextStyle(
          style: titleTextStyle ??
              dialogTheme.titleTextStyle ??
              theme.textTheme.title,
          child: Semantics(
            child: title,
            namesRoute: true,
            container: true,
          ),
        ),
      ));
    }

    if (content != null) {
      children.add(Flexible(
        child: Padding(
          padding: contentPadding,
          child: DefaultTextStyle(
            style: contentTextStyle ??
                dialogTheme.contentTextStyle ??
                theme.textTheme.subhead,
            child: content,
          ),
        ),
      ));
    }

    if (actions != null) {
      children.add(ButtonTheme.bar(
        child: ButtonBar(
          children: actions,
        ),
      ));
    }

    Widget dialogChild = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );

    if (label != null)
      dialogChild = Semantics(
        namesRoute: true,
        label: label,
        child: dialogChild,
      );

    return zAlertDialog;
  }
}

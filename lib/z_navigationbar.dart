import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZNavigationBar extends StatelessWidget with PreferredSizeWidget{
  Widget zNavigationBar;
  BuildContext context;
  Widget leading;
  bool automaticallyImplyLeading;
  bool automaticallyImplyMiddle;
  String previousPageTitle;
  Widget middle;
  Widget trailing;
  Color backgroundColor;
  EdgeInsetsDirectional padding;
  Border border;
  Color actionsForegroundColor;
  bool transitionBetweenRoutes;
  Object heroTag;
  Widget title;
  ShapeBorder shape;

  ZNavigationBar({
    this.context,
    Key key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.automaticallyImplyMiddle = true,
    this.previousPageTitle,
    this.middle,
    this.trailing,
    this.border,
    this.backgroundColor = Colors.teal,
    this.padding,
    this.actionsForegroundColor,
    this.transitionBetweenRoutes = true,
    this.heroTag,
    this.title,
    this.shape,
  }) {
    if (Platform.isAndroid) {
      zNavigationBar = new AppBar(
        key: key,
        backgroundColor: this.backgroundColor,
        leading: this.leading,
        title: this.title,
        shape: this.shape,
      );
    } else {
      zNavigationBar = new CupertinoNavigationBar(
        key: key,
        backgroundColor: this.backgroundColor,
        leading: this.leading,
        middle: this.middle,
        trailing: this.trailing,
        border: this.border,
        padding: this.padding,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return zNavigationBar;
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
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
  List<Widget> actions;
  Widget flexibleSpace;
  PreferredSizeWidget bottom;
  double elevation;
  Brightness brightness;
  IconThemeData iconTheme;
  IconThemeData actionsIconTheme;
  TextTheme textTheme;
  bool primary;
  bool centerTitle;
  double titleSpacing;
  double toolbarOpacity;
  double bottomOpacity;
  
  ZNavigationBar({
    this.context,
    Key key,
    this.leading,
    this.bottom,
    this.flexibleSpace,
    this.actions,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.elevation,
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
    this.title,
    this.shape,
    this.bottomOpacity = 1.0,
    this.toolbarOpacity = 1.0,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.centerTitle,
    this.primary = true,
    this.textTheme
  }) {
    if (Platform.isAndroid) {
      zNavigationBar = new AppBar(
        elevation: this.elevation,
        primary: this.primary,
        centerTitle: this.centerTitle,
        actions: this.actions,
        actionsIconTheme: this.actionsIconTheme,
        automaticallyImplyLeading: this.automaticallyImplyLeading,
        bottom: this.bottom,
        bottomOpacity: this.bottomOpacity,
        brightness: this.brightness,
        flexibleSpace: this.flexibleSpace,
        iconTheme: this.iconTheme,
        textTheme: this.textTheme,
        titleSpacing: this.titleSpacing,
        toolbarOpacity: this.toolbarOpacity,
        key: key,
        backgroundColor: this.backgroundColor,
        leading: this.leading,
        title: this.title,
        shape: this.shape,
      );
    } else {
      zNavigationBar = new CupertinoNavigationBar(
        automaticallyImplyLeading: this.automaticallyImplyLeading,
        actionsForegroundColor: this.actionsForegroundColor,
        automaticallyImplyMiddle: this.automaticallyImplyMiddle,
        previousPageTitle: this.previousPageTitle,
        transitionBetweenRoutes: this.transitionBetweenRoutes,
        key: key,
        backgroundColor: this.backgroundColor,
        leading: this.leading,
        middle: this.middle,
        trailing: (this.trailing != null) ? this.trailing : this.title,
        border: this.border,
        padding: this.padding,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return zNavigationBar;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
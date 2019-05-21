import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZNavigationBar extends StatelessWidget {
  Widget zNavigationBar = new Container();
  BuildContext context;
  Color backgroundColor;
  Widget title;
  Widget leading;
  Widget middle;
  Widget trailing;

  ZNavigationBar({
    this.context,
    this.backgroundColor = Colors.amber,
    this.title,
    this.leading,
    this.middle,
    this.trailing,
  }) {
    if (Platform.isAndroid) {
      zNavigationBar = new AppBar();
    } else {
      zNavigationBar = new CupertinoNavigationBar();
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return zNavigationBar;
  }
}
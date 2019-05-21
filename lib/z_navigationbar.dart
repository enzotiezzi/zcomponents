import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZNavigationBar extends StatelessWidget {
  Widget zNavigationBar = new Container();
  BuildContext context;

  ZNavigationBar({
    this.context,
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
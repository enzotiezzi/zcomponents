import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ZtabBar extends StatelessWidget {
  Widget zTabBar;
  BuildContext context;
  List<BottomNavigationBarItem> items;
  ValueChanged<int> onTap;
  int currentIndex;
  Color backgroundColor;
  Color activeColor;
  Color inactiveColor;
  double iconSize;
  Border border;


  double elevation;
  Color selectedItemColor;
  Color unselectedItemColor;
  Color get fixedColor => selectedItemColor;

  ZtabBar({
    Key key,
    this.items,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor = CupertinoColors.inactiveGray,
    this.iconSize,
    this.border,
    this.currentIndex,
    this.elevation,
    this.selectedItemColor,
    this.unselectedItemColor
  })  : assert(items != null),
        assert(
        items.length >= 2,
        "Tabs need at least 2 items to conform to Apple's HIG",
        ),
        assert(currentIndex != null),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(iconSize != null),
        assert(inactiveColor != null),
        super(key: key) {

    if (Platform.isAndroid) {
      zTabBar = new BottomNavigationBar(
        iconSize: this.iconSize,
        items: this.items,
        backgroundColor: this.backgroundColor,
        selectedItemColor: this.selectedItemColor,
        onTap: this.onTap,
        elevation: this.elevation,
        unselectedItemColor: unselectedItemColor,
      );
    } else {
      zTabBar = new CupertinoTabBar(
        iconSize: this.iconSize,
        items: this.items,
        backgroundColor: this.backgroundColor,
        activeColor: this.selectedItemColor,
        onTap: this.onTap,
        inactiveColor: this.inactiveColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return zTabBar;
  }



}
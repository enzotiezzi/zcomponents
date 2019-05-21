import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZtabBar extends StatelessWidget {
  Widget zTabBar;
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
  Color fixedColor;
  BottomNavigationBarType type;
  double selectedFontSize;
  double unselectedFontSize;
  bool showUnselectedLabels;
  bool showSelectedLabels;

  ZtabBar(
      {Key key,
      this.items,
      this.backgroundColor,
      this.activeColor,
      this.inactiveColor = CupertinoColors.inactiveGray,
      this.iconSize = 24.0,
      this.border,
      this.onTap,
      this.currentIndex = 0,
      this.elevation = 8.0,
      this.selectedItemColor,
      this.unselectedItemColor,
      this.type,
      this.selectedFontSize = 14.0,
      this.unselectedFontSize = 12.0,
      this.showSelectedLabels = true,
      this.showUnselectedLabels,
      this.fixedColor})
      : assert(items != null),
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
        currentIndex: this.currentIndex,
        iconSize: this.iconSize,
        items: this.items,
        backgroundColor: this.backgroundColor,
        selectedItemColor: this.selectedItemColor,
        onTap: this.onTap,
        elevation: this.elevation,
        type: this.type,
        fixedColor: this.fixedColor,
        selectedFontSize: this.selectedFontSize,
        showSelectedLabels: this.showSelectedLabels,
        showUnselectedLabels: this.showUnselectedLabels,
        unselectedItemColor: unselectedItemColor,
        key: this.key,
        unselectedFontSize: this.unselectedFontSize,
      );
    } else {
      zTabBar = new CupertinoTabBar(
        key: this.key,
        border: this.border,
        iconSize: this.iconSize,
        currentIndex: currentIndex,
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

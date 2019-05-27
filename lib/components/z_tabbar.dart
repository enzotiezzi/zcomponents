import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/config/z-platform.dart';

class ZtabBar extends StatelessWidget {
  Widget _zTabBar;

  final List<BottomNavigationBarItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final double iconSize;
  final Border border;
  final double elevation;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color fixedColor;
  final BottomNavigationBarType type;
  final double selectedFontSize;
  final double unselectedFontSize;
  final bool showUnselectedLabels;
  final bool showSelectedLabels;
  final ZPlatform zPlatform;

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
      this.fixedColor,
      this.zPlatform = ZPlatform.isPlatform})
      : super(key: key) {
    switch (zPlatform) {
      case ZPlatform.isPlatform:
        if (Platform.isAndroid) {
          _zTabBar = new BottomNavigationBar(
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
          _zTabBar = new CupertinoTabBar(
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
        break;
      case ZPlatform.isAndroid:
        _zTabBar = new BottomNavigationBar(
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
        break;
      case ZPlatform.isIOS:
        _zTabBar = new CupertinoTabBar(
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
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _zTabBar;
  }
}

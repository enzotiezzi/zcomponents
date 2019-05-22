import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ZSwitch extends StatelessWidget {
 
  Widget _zSwitch;

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final DragStartBehavior dragStartBehavior;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;
  final ImageProvider activeThumbImage;
  final ImageProvider inactiveThumbImage;
  final MaterialTapTargetSize materialTapTargetSize;

  ZSwitch({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
    this.dragStartBehavior = DragStartBehavior.start,
    this.activeThumbImage,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveThumbImage,
    this.inactiveTrackColor,
    this.materialTapTargetSize,
  })  : assert(value != null),
        assert(dragStartBehavior != null) {
    if (Platform.isAndroid) {
      _zSwitch = new Switch(
        onChanged: this.onChanged,
        value: this.value,
        activeColor: this.activeColor,
        dragStartBehavior: this.dragStartBehavior,
        key: key,
        activeThumbImage: this.activeThumbImage,
        activeTrackColor: this.activeTrackColor,
        inactiveThumbColor: this.inactiveThumbColor,
        inactiveThumbImage: this.inactiveThumbImage,
        inactiveTrackColor: this.inactiveTrackColor,
        materialTapTargetSize: this.materialTapTargetSize,
      );
    } else {
      _zSwitch = new CupertinoSwitch(
        onChanged: this.onChanged,
        value: this.value,
        activeColor: this.activeColor,
        dragStartBehavior: this.dragStartBehavior,
        key: key,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _zSwitch;
  }
}

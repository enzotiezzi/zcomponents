import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ZFloatButton extends StatelessWidget {
  Widget _zFloatButton;

  final Widget child;
  final Key key;
  final String tooltip;
  final Color foregroundColor;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double elevation;
  final double highlightElevation;
  final double disabledElevation;
  final bool mini;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final bool isExtended;
  final MaterialTapTargetSize materialTapTargetSize;

  ZFloatButton({
    this.key,
    @required this.onPressed,
    this.child: const Icon(
      Icons.add,
      color: Colors.white,
    ),
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor: const Color(0xff2BB9B4),
    this.elevation,
    this.highlightElevation,
    this.disabledElevation,
    this.mini = false,
    this.shape,
    this.clipBehavior = Clip.none,
    this.materialTapTargetSize,
    this.isExtended = false,
  }) : super(key: key) {
    _zFloatButton = new FloatingActionButton(
        onPressed: this.onPressed,
        elevation: this.elevation,
        child: this.child,
        backgroundColor: this.backgroundColor,
        shape: this.shape,
        clipBehavior: this.clipBehavior,
        disabledElevation: this.disabledElevation,
        foregroundColor: this.foregroundColor,
        highlightElevation: this.highlightElevation,
        isExtended: this.isExtended,
        materialTapTargetSize: this.materialTapTargetSize,
        mini: this.mini,
        tooltip: this.tooltip,
        key: this.key);
  }

  @override
  Widget build(BuildContext context) {
    return _zFloatButton;
  }
}

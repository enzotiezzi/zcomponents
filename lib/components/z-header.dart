import 'package:flutter/material.dart';

class ZHeader extends StatelessWidget {
  Widget _zHeader;

  final Key key;
  final Widget child;
  final MaterialType type;
  final double elevation;
  final Color color;
  final Color shadowColor;
  final TextStyle textStyle;
  final ShapeBorder shape;
  final bool borderOnForeground;
  final Clip clipBehavior;
  final Duration animationDuration;
  final BorderRadiusGeometry borderRadius;
  final String titulo;

  ZHeader({
    this.key,
    this.type = MaterialType.canvas,
    this.elevation = 0.0,
    this.color,
    this.shadowColor = const Color(0xFF000000),
    this.textStyle,
    this.borderRadius,
    this.shape,
    this.borderOnForeground = true,
    this.clipBehavior = Clip.none,
    this.animationDuration = kThemeChangeDuration,
    this.child,
    this.titulo,
  }) : super(key: key) {
    _zHeader = new Material(
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.7)))),
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0),
        child: new Text(titulo,
            style: new TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _zHeader;
  }
}

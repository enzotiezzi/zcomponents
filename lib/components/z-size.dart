import 'package:flutter/widgets.dart';

class ZSize extends StatelessWidget {
  final Key key;
  final Widget child;
  final BuildContext context;
  final double percentHeight;
  final double percentWidth;
  final double maxHeight;
  final double maxWidth;

  final bool quadrado;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;

  double _height;
  double _width;

  ZSize({
    this.key,
    @required this.context,
    @required this.child,
    this.padding = const EdgeInsets.all(2.0),
    this.height = 0,
    this.width = 0,
    this.quadrado = false,
    this.maxHeight = 450,
    this.maxWidth = 450,
    this.percentHeight = 20,
    this.percentWidth = 50,
  }) : super(key: key) {
    initSize();
  }

  void initSize() {
    if (height < 1)
      _height = (MediaQuery.of(context).size.height * percentHeight) / 100;
    else
      _height = height;
    if (width < 1)
      _width = (MediaQuery.of(context).size.width * percentWidth) / 100;
    else
      _width = width;

    if (_height > maxHeight) _height = maxHeight;
    if (_width > maxWidth) _width = maxWidth;

    if (quadrado) if (_width > _height)
      _height = _width;
    else
      _width = _height;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: new Padding(padding: padding, child: child), height: _height, width: _width);
  }
}

import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:z_components/config/z-tipo-header.dart';

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
  final ZTipoHeader zTipos;
  final List<Widget> children;
  bool titulosAppBar = false;

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
    this.titulo: "",
    this.zTipos = ZTipoHeader.isPadrao,
    this.children = const <Widget>[],
    this.titulosAppBar,
  }) : super(key: key) {
    switch (zTipos) {
      case ZTipoHeader.isPadrao:
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
        break;
      case ZTipoHeader.isExpansion:
        _zHeader = new Material(
          elevation: 4.0,
          color: const Color(0xfff0f0f0),
          child: new ConfigurableExpansionTile(
            initiallyExpanded: true,
            bottomBorderOn: true,
            animatedWidgetFollowingHeader: new Icon(Icons.arrow_drop_down),
            header: new Expanded(
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (titulosAppBar == false)
                      ? new Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              left: 16.0, bottom: 10.0, top: 10.0),
                          child: new Text(titulo,
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        )
                      : new Container(
                          child: child,
                        ),
                ],
              ),
            ),
            children: children,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _zHeader;
  }
}

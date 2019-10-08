import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:z_components/config/z-tipo-header.dart';
import 'package:z_components/styles/main-style.dart';

class ZHeader extends StatefulWidget {
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
  final bool titulosAppBar;

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
    this.titulosAppBar = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ZHeaderState();
}
class ZHeaderState extends State<ZHeader> {

  @override
  Widget build(BuildContext context) {
    switch (widget.zTipos) {
      case ZTipoHeader.isPadrao:
        return new Material(
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.7)))),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: new Text(widget.titulo,
              style: MainStyle.get(context).titleStyleText,),
          ),
        );
        break;
      case ZTipoHeader.isExpansion:
        return  new Material(
          elevation: 4.0,
          color: const Color(0xfff0f0f0),
          child: new ConfigurableExpansionTile(
            initiallyExpanded: false,
            bottomBorderOn: true,
            animatedWidgetFollowingHeader: new Icon(Icons.arrow_drop_down),
            header: new Expanded(
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (widget.titulosAppBar == false)
                      ? new Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        left: 16.0, bottom: 10.0, top: 10.0),
                    child: new Text(widget.titulo,
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  )
                      : new Container(
                    child: widget.child,
                  ),
                ],
              ),
            ),
            children: widget.children,
          ),
        );
    }
    return build(context);
  }
}

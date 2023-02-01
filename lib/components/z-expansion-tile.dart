
import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/material.dart';

class ZExpansion extends StatefulWidget {
  final String? titulo;
  final Widget? childExpand;
  final Widget? childTitle;

  ZExpansion({
    Key? key,
    this.childTitle,
    this.childExpand,
    this.titulo = "",
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZExpansionState();
}

class _ZExpansionState extends State<ZExpansion> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  void dismiss() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.1), width: 2.0),
            color: const Color(0xffDBDBDB).withOpacity(0.6),
            borderRadius: BorderRadius.all(Radius.circular(7.0))),
        margin: EdgeInsets.only(left: 7.0, right: 7.0),
        child: new ConfigurableExpansionTile(
          //key: _expansions,
          //initiallyExpanded: _collapsed,
          onExpansionChanged: (bool) {},
          animatedWidgetFollowingHeader: new Icon(Icons.keyboard_arrow_down),
          header: new Expanded(
            child: new Container(
              padding: EdgeInsets.all(3.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  (widget.childTitle == null)
                      ? new Container()
                      : widget.childTitle!,
                ],
              ),
            ),
          ),
          childrenBody:
            (widget.childExpand == null) ? new Container() : widget.childExpand!

        ));
  }
}

import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';

class ZExpansion extends StatefulWidget {
  _ZExpansionState state;
  String titulo;
  Widget childExpand;
  Widget childTitle;


  ZExpansion({Key key,
    this.childTitle,
    this.childExpand,
    this.titulo = "",
  }) : super(key: key);

  @override
  _ZExpansionState createState() {
    state = new _ZExpansionState();

    return state;
  }
}

class _ZExpansionState extends State<ZExpansion> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
  }

  void dismiss() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      new Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.withOpacity(0.1), width: 2.0),
              color: const Color(0xffDBDBDB).withOpacity(0.6),
              borderRadius: BorderRadius.all(Radius.circular(7.0))),
          margin: EdgeInsets.only(left: 7.0, right: 7.0),
          child:new ConfigurableExpansionTile(
            //key: _expansions,
            //initiallyExpanded: _collapsed,
            onExpansionChanged: (bool) {
              setState(() {
              });
            },
            animatedWidgetFollowingHeader:
            new Icon(Icons.keyboard_arrow_down),
            header: new Expanded(
              child: new Container(
                padding: EdgeInsets.all(3.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    (widget.childTitle == null)?
                        new Container():widget.childTitle
                  ],
                ),
              ),
            ),
            children: <Widget>[(widget.childExpand == null)?
            new Container():widget.childExpand],
          ));
  }
}

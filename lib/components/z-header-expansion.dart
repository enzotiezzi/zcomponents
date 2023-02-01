import 'package:flutter/material.dart';
import 'package:z_components/styles/main-style.dart';

class ZHeaderExpansion extends StatefulWidget {
  final String? titulo;
  final bool? collapsed;
  final GestureTapCallback? onTap;

  ZHeaderExpansion({
    Key? key,
    this.titulo = "",
    this.collapsed,
    this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZHeaderExpansionState();
}

class _ZHeaderExpansionState extends State<ZHeaderExpansion>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  void dismiss() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.7)))),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: new Text(
              widget.titulo ?? "",
              style: MainStyle.get(context).titleStyleText,
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  if(widget.onTap !=null){
                    widget.onTap!();
                  }
                },
                child: new Container(
                  padding: EdgeInsets.only(left: 7.0, right: 7.0),
                  color: Colors.transparent,
                  child: (widget.collapsed == true)
                      ? new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Icon(
                              Icons.keyboard_arrow_up,
                              size: 15.0,
                              color: const Color(0xff2BBAB4),
                            ),
                            new Icon(
                              Icons.keyboard_arrow_down,
                              size: 15.0,
                              color: const Color(0xff2BBAB4),
                            )
                          ],
                        )
                      : new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Icon(
                              Icons.keyboard_arrow_down,
                              size: 15.0,
                              color: const Color(0xff2BBAB4),
                            ),
                            new Icon(
                              Icons.keyboard_arrow_up,
                              size: 15.0,
                              color: const Color(0xff2BBAB4),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

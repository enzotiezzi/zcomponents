import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:z_components/components/z-size.dart';

class ZBaseLine extends StatelessWidget {
  Widget _zBaseLine;

  final Key key;
  final BuildContext context;
  final String title;
  final Widget ztextField;

  ZBaseLine({this.key, this.context, this.title, this.ztextField}) : super(key: key) {
    _zBaseLine = new Container(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                    flex: 3,
                    child: new Container(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 16.0),
                      child: new Text(
                        title,
                        style: new TextStyle(color: Color(0xffA0A0A0)),
                      ),
                    )),
                new Expanded(
                    flex: 7,
                    child: new Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      child: ztextField,
                    ))
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new ZSize(
                    context: context,
                    percentWidth: 72.0,
                    //width: 260,
                    height: 1,
                    child: new Container(
                      color: Colors.grey.withOpacity(0.3),
                    ))
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _zBaseLine;
  }
}

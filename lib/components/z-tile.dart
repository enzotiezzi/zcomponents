import 'package:flutter/material.dart';

class ZTile extends StatefulWidget {
  Widget leading;
  Widget trailing;

  ZTile({this.leading, this.trailing});

  @override
  _ZTileState createState() => _ZTileState();
}

class _ZTileState extends State<ZTile> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              child: widget.leading,
              margin: new EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            ),
            new Container(
              child: widget.trailing,
              margin: new EdgeInsets.only(right: 16.0,),
            ),
          ],
        ),

    );
  }
}

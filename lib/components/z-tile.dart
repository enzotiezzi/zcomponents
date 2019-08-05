import 'package:flutter/material.dart';

class ZTile extends StatefulWidget {
  Widget leading;
  Widget trailing;
  GestureTapCallback onTap;

  ZTile({this.leading, this.trailing, this.onTap});

  @override
  _ZTileState createState() => _ZTileState();
}

class _ZTileState extends State<ZTile> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: widget.onTap,
      child: new Container(
        color: Colors.white,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              child: widget.leading,
              margin: new EdgeInsets.only(left: 16.0, top: 10.0, bottom: 10.0),
            ),
            new Container(
              child: widget.trailing,
              margin: new EdgeInsets.only(
                right: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

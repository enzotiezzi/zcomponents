import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZTile extends StatefulWidget {
  final Widget leading;
  final Widget trailing;
  final GestureTapCallback onTap;
  double margem;

  ZTile({this.leading, this.trailing, this.onTap, this.margem});

  @override
  _ZTileState createState() => _ZTileState();

}

class _ZTileState extends State<ZTile> {
  @override
  void initState() {
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.margem == null){
      widget.margem = 16;
    }

    return new GestureDetector(
      onTap: widget.onTap,
      child: new Container(
        color: Colors.white,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              child: widget.leading,
              margin: new EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
            ),
            new Container(
              child: widget.trailing,
              margin: EdgeInsets.only(right: widget.margem),
            ),
          ],
        ),
      ),
    );
  }
}

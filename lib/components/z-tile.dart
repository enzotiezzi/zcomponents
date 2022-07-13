import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZTile extends StatefulWidget {
  final Widget leading;
  final Widget trailing;
  final GestureTapCallback onTap;
  double margem;
  bool disable;

  ZTile({this.leading, this.trailing, this.onTap, this.margem, this.disable});

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

    if (widget.disable == null) {
      widget.disable = false;
    }

    if (widget.disable){
      return new Opacity(
          opacity: 0.4,
          child: _zTile(),
      );
    } else {
     return _zTile();
    }
  }

  Widget _zTile(){
    return new GestureDetector(
      onTap: widget.disable ? null : widget.onTap,
      child: new Container(
        color: widget.disable ? Colors.grey.withOpacity(0.1) : Colors.white,
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
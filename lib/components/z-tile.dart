import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZTile extends StatefulWidget {
  final Widget? leading;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  double? margem;
  bool? disable;

  ZTile({this.leading, this.trailing, this.onTap, this.margem =0, this.disable});

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

    if (widget.disable!){
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
      onTap:(){
        if(widget.disable !=null && !widget.disable! && widget.onTap !=null){
          widget.onTap!();
        }
      },
      child: new Container(
        color: _retornarCor(),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              child: _retornarLeading(),
              margin: new EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
            ),
            new Container(
              child: _retornarTrailing(),
              margin: EdgeInsets.only(right: widget.margem!),
            ),
          ],
        ),
      ),
    );
  }

  Color _retornarCor(){
    if(widget.disable != null && widget.disable!){
      return Colors.grey.withOpacity(0.1);
    }else{
      return Colors.white;
    }
  }

  Widget _retornarLeading(){
    if(widget.leading != null){
      return widget.leading!;
    }else{
      return Container();
    }
  }

  Widget _retornarTrailing(){
    if(widget.trailing != null){
      return widget.trailing!;
    }else{
      return Container();
    }
  }
}
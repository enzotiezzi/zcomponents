import 'package:flutter/material.dart';
import 'package:z_components/config/z-tipo-textos.dart';

class ZText extends StatefulWidget {
  String text;
  String tituloText;
  ZTipoTextos zTipos;

  ZText({this.text: "", this.tituloText: "", this.zTipos});

  @override
  _ZTextState createState() => _ZTextState();
}

class _ZTextState extends State<ZText> {
  @override
  Widget build(BuildContext context) {
    return (widget.zTipos ==ZTipoTextos.isPadrao)?new Container(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                    flex: 3,
                    child: new Container(alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                          top: 12.0, bottom: 12.0, left: 16.0),
                      child: new Text(
                        widget.tituloText,
                        style: new TextStyle(color: Color(0xFF999999)),
                      ),
                    )),
                new Expanded(
                    flex: 7,
                    child: new Container(
                      margin: const EdgeInsets.only(left: 8.0, right: 16.0, top: 12.0, bottom: 12.0),
                      child: new Container(
                        child: new Text(
                          widget.text,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ))
              ],
            ),
          ],
        )):
    new Container(
      padding: EdgeInsets.only(left: 15.0, bottom: 8.0, top: 16.0),
      alignment: Alignment.centerLeft,
      child: new Text(
        widget.tituloText,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

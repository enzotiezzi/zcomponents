import 'package:flutter/material.dart';
import 'package:z_components/config/z-tipo-textos.dart';
import 'package:z_components/styles/main-style.dart';

class ZText extends StatefulWidget {
  final String text;
  final String tituloText;
  final ZTipoTextos zTipos;

  ZText(
      {this.text: "", this.tituloText: "", this.zTipos: ZTipoTextos.isPadrao});

  @override
  _ZTextState createState() => _ZTextState();
}

class _ZTextState extends State<ZText> {
  @override
  Widget build(BuildContext context) {
    return (widget.zTipos == ZTipoTextos.isPadrao)
        ? new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text(widget.tituloText,
                              style:
                                  MainStyle.get(context).mainStyleTextBaseLine),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(
                              left: 8.0, right: 16.0, top: 12.0, bottom: 12.0),
                          child: new Container(
                            child: new Text(
                              widget.text,
                              style: MainStyle.get(context)
                                  .mainStyleTextBaseLineInput,
                            ),
                          ),
                        ))
                  ],
                ),
              ],
            ))
        : new Container(
            padding: EdgeInsets.only(left: 15.0, bottom: 8.0, top: 16.0),
            alignment: Alignment.centerLeft,
            child: new Text(widget.tituloText,
                style: MainStyle.get(context).mainStyleTextBaseLine),
          );
  }
}

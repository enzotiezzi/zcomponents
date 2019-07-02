import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:z_components/components/z-size.dart';
import 'package:z_components/config/z-tipos-baseline.dart';

class ZBaseLine extends StatelessWidget {
  Widget _zBaseLine;

  final Key key;
  final BuildContext context;
  final ZTipoBaseline zTipos;

  ZBaseLine(
      {this.key, this.context, this.zTipos = ZTipoBaseline.isNomeCompleto})
      : super(key: key) {
    switch (zTipos) {
      case ZTipoBaseline.isNomeCompleto:
        _zBaseLine = new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text(
                            "Nome Completo",
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "Nome Completo",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
      case ZTipoBaseline.isCPF:
        _zBaseLine = new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text(
                            "CPF",
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "*** . *** . *** - **",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "XXX.XXX.XXX-XX",
                                  maskTWO: "XXX.XXX.XXX-XX")
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
      case ZTipoBaseline.isCelular:
        _zBaseLine = new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text(
                            "Celular",
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "( ** ) 9 **** - ****",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "(XX)XXXXX-XXXX",
                                  maskTWO: "(XX)XXXXX-XXXX")
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
      case ZTipoBaseline.isEmail:
        _zBaseLine = new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text(
                            "E-mail",
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "email@email.com.br",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
      case ZTipoBaseline.isDataNascimento:
        _zBaseLine = new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        flex: 3,
                        child: new Container(
                          padding: const EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 16.0),
                          child: new Text(
                            "Data Nascimento",
                            style: new TextStyle(color: Color(0xFF999999)),
                          ),
                        )),
                    new Expanded(
                        flex: 7,
                        child: new Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: new TextField(
                            cursorColor: Color(0xFF2BBAB4),
                            style: new TextStyle(color: Color(0xFF000000)),
                            decoration: InputDecoration(
                              hintText: "dd / mm / aaaa",
                              hintStyle: new TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000).withOpacity(0.3)),
                            ),
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "XX/XX/XXXX", maskTWO: "XX/XX/XXXX")
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _zBaseLine;
  }
}

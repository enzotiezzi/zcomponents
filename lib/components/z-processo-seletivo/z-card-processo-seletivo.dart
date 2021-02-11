import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-processo-seletivo/models/processo-seletivo.dart';

class ZCardProcessoSeletivo extends StatefulWidget {
  final ThemeData themeData;
  final ProcessoSeletivo processoSeletivo;

  ZCardProcessoSeletivo(
      {@required this.themeData, @required this.processoSeletivo});

  @override
  State<StatefulWidget> createState() => _ZCardProcessoSeletivoState();
}

class _ZCardProcessoSeletivoState extends State<ZCardProcessoSeletivo> {
  double size = 14.0;
  Color color = const Color(0xFF707070);

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 3,
      child: new Padding(
        padding: const EdgeInsets.all(0.0),
        child: new Column(
          children: [
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Column(
                    children: [
                      new Text(
                        "Aux. Manutenção - São Paulo",
                        style: widget.themeData.textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ],
                  ),
                  new Column(
                    children: [
                      new Row(
                        children: [
                          new Text(
                            "1234506...",
                            style: new TextStyle(fontSize: size, color: color),
                          ),
                          new Text("10d",
                              style:
                                  new TextStyle(fontSize: size, color: color))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            new Container(
              color: widget.themeData.backgroundColor,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(1.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(
                        margin: const EdgeInsets.all(2.0),
                        child: new Row(
                          children: [
                            new Icon(
                              Icons.work_outline,
                              size: size,
                              color: color,
                            ),
                            new Text(
                              "Auxiliar de Limpeza",
                              style:
                                  new TextStyle(fontSize: size, color: color),
                            )
                          ],
                        ),
                      ),
                      new Row(
                        children: [
                          new Icon(
                            Icons.attach_money,
                            color: color,
                            size: size,
                          ),
                          new Text(
                            "1.299/Mês, CLT (Integral)",
                            style: new TextStyle(fontSize: size, color: color),
                          )
                        ],
                      )
                    ],
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Row(
                        children: [
                          new Icon(
                            Icons.location_on,
                            color: color,
                            size: size,
                          ),
                          new Text("SP-Morumbi",
                              style:
                                  new TextStyle(fontSize: size, color: color))
                        ],
                      ),
                      new Row(
                        children: [
                          new Icon(
                            Icons.money,
                            color: color,
                            size: size,
                          ),
                          new Text("VT, VR, VA, CB, PLR",
                              style:
                                  new TextStyle(fontSize: size, color: color))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Row(
                        children: [
                          new Icon(
                            Icons.wysiwyg,
                            color: color,
                            size: size,
                          ),
                          new Text("Etapa 1/1",
                              style: new TextStyle(
                                  fontSize: size,
                                  color: color,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Row(
                        children: [
                          new Icon(
                            Icons.work_outline,
                            color: color,
                            size: size,
                          ),
                          new Text("12",
                              style: new TextStyle(
                                  fontSize: size,
                                  fontWeight: FontWeight.bold,
                                  color: color)),
                          new Icon(
                            Icons.people,
                            color: color,
                            size: size,
                          ),
                          new Text("                       "),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

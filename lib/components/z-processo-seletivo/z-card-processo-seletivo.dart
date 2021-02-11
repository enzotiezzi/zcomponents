import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZCardProcessoSeletivo extends StatefulWidget {
  final ThemeData themeData;

  ZCardProcessoSeletivo({@required this.themeData,});

  @override
  State<StatefulWidget> createState() => _ZCardProcessoSeletivoState();
}

class _ZCardProcessoSeletivoState extends State<ZCardProcessoSeletivo> {
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
                        style: widget.themeData.textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  new Column(
                    children: [
                      new Row(
                        children: [new Text("1234506..."), new Text("10d")],
                      )
                    ],
                  )
                ],
              ),
            ),
            new Container(
              color: const Color(0xFFF0F0F0),
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(1.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Row(
                        children: [
                          new Icon(Icons.work_outline),
                          new Text("Auxiliar de Limpeza")
                        ],
                      ),
                      new Row(
                        children: [
                          new Icon(Icons.attach_money),
                          new Text("1.299/Mês, CLT (Integral)")
                        ],
                      )
                    ],
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Row(
                        children: [
                          new Icon(Icons.location_on),
                          new Text("SP-Morumbi")
                        ],
                      ),
                      new Row(
                        children: [
                          new Icon(Icons.money),
                          new Text("VT, VR, VA, CB, PLR")
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
                          new Icon(Icons.wysiwyg),
                          new Text("Etapa 1/1")
                        ],
                      ),
                    ],
                  ),
                  new Column(
                    children: [
                      new Row(
                        children: [
                          new Icon(Icons.work_outline),
                          new Text("12"),
                          new Icon(Icons.people),
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

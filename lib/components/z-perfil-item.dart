import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZPerfilItem extends StatefulWidget {
  int count;
  List<String> listaTextos;
  List<IconData> listaIcones;

  ZPerfilItem({this.count = 0, this.listaIcones, this.listaTextos});

  @override
  _ZPerfilItemState createState() => _ZPerfilItemState();
}

class _ZPerfilItemState extends State<ZPerfilItem> {
  @override
  Widget build(BuildContext context) {
    return new GridView.builder(
      shrinkWrap: true,
        itemCount: widget.count,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10.0, mainAxisSpacing: 10.0, crossAxisCount: 3),
        itemBuilder: (context, index) {
          return new Material(
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
            color: Colors.white,
            elevation: 2.0,
            child: new Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(bottom: 10.0, top: 18.0, left: 2.0),
                    child: new Icon(
                      widget.listaIcones[index],
                      color: const Color(0xff2BBAB4),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: new Text(
                      widget.listaTextos[index],
                      style: TextStyle(color: const Color(0xff999999)),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
    ;
  }
}

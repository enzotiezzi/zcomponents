import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZPerfilItem extends StatefulWidget {
  final int numeroQuadrados;
  final List<String> listaTextos;
  final List<IconData> listaIcones;
  final List<dynamic> listaOnTap;
  final Color color;

  ZPerfilItem({this.numeroQuadrados = 0, this.listaIcones, this.listaTextos, this.listaOnTap, this.color});

  @override
  _ZPerfilItemState createState() => _ZPerfilItemState();
}

class _ZPerfilItemState extends State<ZPerfilItem> {
  @override
  Widget build(BuildContext context) {
    return new GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.numeroQuadrados,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10.0, mainAxisSpacing: 10.0, crossAxisCount: 3),
      itemBuilder: (context, index) {
        return (index == widget.numeroQuadrados - 1 ||
                index == widget.numeroQuadrados - 2 ||
                index == widget.numeroQuadrados - 3)
            ? new GestureDetector(
          onTap: widget.listaOnTap[index],
          child: new Container(
          margin: EdgeInsets.only(bottom: 2.0),
          child: new Material(
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
                    margin: EdgeInsets.only(
                        bottom: 6.0, top: 8.0, left: 8.0, right: 8.0),
                    child: new Icon(
                      widget.listaIcones[index],
                      color: widget.color,
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: (widget.listaTextos[index] != null)
                        ? new Text(
                      widget.listaTextos[index],
                      style:
                      TextStyle(color: const Color(0xff707070)),
                    )
                        : new Text(
                      widget.listaTextos[index],
                      style:
                      TextStyle(color: const Color(0xff707070)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),)
            : new GestureDetector(
          onTap: widget.listaOnTap[index],
          child: new Material(
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
                  margin: EdgeInsets.only(
                      bottom: 6.0, top: 8.0, left: 8.0, right: 8.0),
                  child: new Icon(
                    widget.listaIcones[index],
                    color: widget.color,
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: (widget.listaTextos[index] != null)
                      ? new Text(
                    widget.listaTextos[index],
                    style:
                    TextStyle(color: const Color(0xff707070)),
                  )
                      : new Text(
                    widget.listaTextos[index],
                    style:
                    TextStyle(color: const Color(0xff707070)),
                  ),
                )
              ],
            ),
          ),
        ),);
      },
    );
  }
}

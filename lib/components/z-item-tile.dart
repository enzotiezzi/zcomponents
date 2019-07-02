import 'package:flutter/material.dart';

class ZItemTile extends StatefulWidget {
  String textoTitulo;
  String textoDois;
  String textoTres;
  String textoQuatro;
  String textoCinco;
  String textoSeis;
  String textoSete;
  String textoCodigo;
  bool status;
  var funcao;

  ZItemTile(
      {this.textoCinco: "",
      this.textoDois: "",
      this.textoQuatro: "",
      this.textoSeis: "",
      this.textoSete: "",
      this.textoTitulo: "",
      this.textoTres: "",
      this.funcao,
      this.textoCodigo,
      this.status: false});

  @override
  _ZItemTileState createState() => _ZItemTileState();
}

class _ZItemTileState extends State<ZItemTile> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(7.0))),
      alignment: Alignment.centerLeft,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Expanded(
            flex: 2,
            child: new Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0))),
              margin: EdgeInsets.only(left: 3.0),
              width: 50.0,
              height: 108.0,
              child: new Icon(
                Icons.insert_photo,
                color: Color(0xFFC7C7CC),
              ),
            ),
          ),
          new Expanded(
              flex: 8,
              child: new GestureDetector(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          width: 180.0,
                          margin:
                              EdgeInsets.only(left: 8.0, bottom: 4.0, top: 8.0),
                          child: new Text(
                            widget.textoTitulo,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        new Container(
                          margin:
                              EdgeInsets.only(left: 8.0, bottom: 4.0, top: 8.0, right: 2.0),
                          child: new Text(
                            widget.textoCodigo,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Container(
                              margin: EdgeInsets.only(
                                  left: 8.0, right: 3.0, bottom: 4.0),
                              child: new Icon(
                                Icons.my_location,
                                color: Color(0xFFA3A3A3),
                                size: 20.0,
                              ),
                            ),
                            new Container(
                              width: (MediaQuery.of(context).size.width / 2.3),
                              margin: EdgeInsets.only(
                                  left: 8.0, right: 3.0, bottom: 4.0),
                              child: new Text(
                                widget.textoDois,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xFFA3A3A3),
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
      (widget.status == true)?new Row(
                          children: <Widget>[
                            new Container(
                              height: 10.0,
                              width: 10.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xff1AC15D)),
                            ),
                            new Container(margin: EdgeInsets.only(right: 2.0, left: 2.0),
                              child: new Text(
                                "Ativo",
                                style:
                                    TextStyle(color: const Color(0xff999999)),
                              ),
                            )
                          ],
                        ):  new Row(
        children: <Widget>[
          new Container(
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff999999)),
          ),
          new Container(margin: EdgeInsets.only(right: 2.0, left: 2.0),
            child: new Text(
              "Inativo",
              style:
              TextStyle(color: const Color(0xff999999)),
            ),
          )
        ],
      )

                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(
                              left: 8.0, right: 3.0, bottom: 4.0),
                          child: new Icon(
                            Icons.work,
                            size: 20,
                            color: Color(0xFFA3A3A3),
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(
                              left: 8.0, right: 3.0, bottom: 4.0),
                          child: new Text(
                            widget.textoTres,
                            style: TextStyle(
                                color: Color(0xFFA3A3A3),
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.only(bottom: 4.0, left: 8.0),
                          child: new Icon(
                            Icons.access_time,
                            size: 20,
                            color: Color(0xFFA3A3A3),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(bottom: 4.0, left: 6.0),
                          child: new Text(
                            "${widget.textoQuatro} ${widget.textoCinco} - ${widget.textoSeis}",
                            style: TextStyle(
                                color: Color(0xFFA3A3A3),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(bottom: 4.0, left: 4.0),
                          child: new Text(
                            "(",
                            style: TextStyle(
                                color: Color(0xFFA3A3A3),
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: new Icon(
                            Icons.restaurant_menu,
                            color: Color(0xFFA3A3A3),
                            size: 14.0,
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(bottom: 4.0, left: 2.0),
                          child: new Text(
                            "${widget.textoSete})",
                            style: TextStyle(
                                color: Color(0xFFA3A3A3),
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                onTap: widget.funcao,
              )),

        ],
      ),
    );
  }
}

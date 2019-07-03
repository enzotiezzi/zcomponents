import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';

class ZExpendableItemTile extends StatefulWidget {
  String textoTitulo;
  String textoDois;
  String textoTres;
  String textoQuatro;
  String textoCinco;
  String textoSeis;
  String textoSete;
  String textoCodigo;
  String textoIconeUm;
  String textoIconeDois;
  String textoIconeTres;
  String textoIconeQuatro;
  Widget iconeUm;
  Widget iconeDois;
  Widget iconeTres;
  Widget iconeQuatro;
  bool status;
  var funcao;
  var image;
  var funcaoIconeUm;
  var funcaoIconeDois;
  var funcaoIconeTres;
  var funcaoIconeQuatro;

  ZExpendableItemTile(
      {this.textoCinco: "",
      this.textoDois: "",
      this.textoQuatro: "",
      this.textoSeis: "",
      this.textoSete: "",
      this.textoTitulo: "",
      this.textoTres: "",
      this.funcao,
      this.textoCodigo: "",
      this.status: false,
      this.image,
      this.funcaoIconeDois,
      this.funcaoIconeQuatro,
      this.funcaoIconeTres,
      this.funcaoIconeUm,
      this.iconeDois,
      this.iconeQuatro,
      this.iconeTres,
      this.iconeUm,
      this.textoIconeDois: "",
      this.textoIconeQuatro: "",
      this.textoIconeTres: "",
      this.textoIconeUm: ""});

  @override
  _ZExpendableItemTileState createState() => _ZExpendableItemTileState();
}

class _ZExpendableItemTileState extends State<ZExpendableItemTile> {
  @override
  Widget build(BuildContext context) {
    return new Container(margin: EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(       color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(7.0)),),
      child: ConfigurableExpansionTile(
        animatedWidgetFollowingHeader: new Container(padding: EdgeInsets.all(5.0),child: new Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),),
        header: new Expanded(
          child: new ZItemTile(
            isExpand: "isExpand",
            funcao: widget.funcao,
            image: widget.image,
            status: widget.status,
            textoCodigo: widget.textoCodigo,
            textoSete: widget.textoSete,
             textoSeis: widget.textoSeis,
            textoCinco: widget.textoCinco,
            textoQuatro: widget.textoQuatro,
            textoTres: widget.textoTres,
            textoDois: widget.textoDois,
            textoTitulo: widget.textoTitulo,
          ),
        ),
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey.withOpacity(0.2)))),
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: new GestureDetector(
                  child: new Container(
                    padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                color: Colors.grey.withOpacity(0.2)))),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          child: widget.iconeUm,
                        ),
                        new Text("${widget.textoIconeUm}",
                            style: TextStyle(
                                fontSize: 10.0, color: const Color(0xff2BB9B4)))
                      ],
                    ),
                  ),
                  onTap: widget.funcaoIconeUm,
                )),
                new Expanded(
                    child: new GestureDetector(
                  child: new Container(
                    padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                color: Colors.grey.withOpacity(0.2)))),
                    child: new Column(
                      children: <Widget>[
                        new Container(child: widget.iconeDois),
                        new Text(widget.textoIconeDois,
                            style: TextStyle(
                                fontSize: 10.0, color: const Color(0xff2BB9B4)))
                      ],
                    ),
                  ),
                  onTap: widget.funcaoIconeDois,
                )),
                new Expanded(
                    child: new GestureDetector(
                  onTap: widget.funcaoIconeTres,
                  child: new Container(
                    padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                color: Colors.grey.withOpacity(0.2)))),
                    child: new Column(
                      children: <Widget>[
                        new Container(child: widget.iconeTres),
                        new Text(widget.textoIconeTres,
                            style: TextStyle(
                                fontSize: 10.0, color: const Color(0xff2BB9B4)))
                      ],
                    ),
                  ),
                )),
                new Expanded(
                    child: new GestureDetector(
                  onTap: widget.funcaoIconeQuatro,
                  child: new Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
                    child: new Column(
                      children: <Widget>[
                        new Container(child: widget.iconeQuatro),
                        new Text(
                          widget.textoIconeQuatro,
                          style: TextStyle(
                              fontSize: 10.0, color: const Color(0xff2BB9B4)),
                        )
                      ],
                    ),
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

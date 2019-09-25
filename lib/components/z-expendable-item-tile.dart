import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';

class ZExpendableItemTile extends StatefulWidget {
  String textoIconeUm;
  String textoIconeDois;
  String textoIconeTres;
  String textoIconeQuatro;
  Widget iconeUm;
  Widget iconeDois;
  Widget iconeTres;
  Widget iconeQuatro;
  bool status;
  Function funcao;
  var image;
  var funcaoIconeUm;
  var funcaoIconeDois;
  var funcaoIconeTres;
  var funcaoIconeQuatro;
  Widget imagemPerfil;
  var onTapVoltar;
  var onTapImage;
  String idConta;
  String token;
  String cpf;

  ZExpendableItemTile(
      {
      this.funcao,
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
      this.textoIconeUm: "",
      this.token,
      this.cpf,
      this.idConta,
      this.imagemPerfil,
      this.onTapImage,
      this.onTapVoltar, String textoTitulo,
      });

  @override
  _ZExpendableItemTileState createState() => _ZExpendableItemTileState();
}

class _ZExpendableItemTileState extends State<ZExpendableItemTile> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      child: ConfigurableExpansionTile(
        animatedWidgetFollowingHeader: new Container(
          padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 0.0, bottom: 0.0),
          child: new Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
        ),
        header: new Expanded(
          child: new ZItemTile(
            isExpand: "isExpand",
            onTapImage: widget.onTapImage,
            imagemPerfil: widget.imagemPerfil,
            token: widget.token,
            cpf: widget.cpf,
            idConta: widget.idConta,
            funcao: widget.funcao,
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
                        new Text("${widget.textoIconeUm}".toUpperCase(),
                            style: TextStyle(
                                fontSize: 10.0, color: const Color(0xff2BB9B4),))
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
                        new Text(widget.textoIconeDois.toUpperCase(),
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
                        new Text(widget.textoIconeTres.toUpperCase(),
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
                          widget.textoIconeQuatro.toUpperCase(),
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

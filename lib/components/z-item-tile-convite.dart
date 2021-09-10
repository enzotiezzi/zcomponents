import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/view-model/item-tile-convite-viewmodel.dart';

class ZItemTileConvite extends StatefulWidget {
  final Function onTileIsSelected;
  final ItemTileViewModel itemTileViewModel;

  ZItemTileConvite({
    this.itemTileViewModel,
    this.onTileIsSelected,
  });

  @override
  _ZItemTileConviteState createState() => _ZItemTileConviteState();
}

class _ZItemTileConviteState extends State<ZItemTileConvite> {
  Widget retornarStatus() {
    if (widget.itemTileViewModel.status == null) {
      return new Text(
        'INDICAR STATUS',
        style: new TextStyle(
            fontSize: 14,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600),
      );
    } else {
      return new Row(
        children: [
          new Container(
            child: new Icon(
              Icons.circle,
              color: retornarCorStatus(),
              size: 8,
            ),
            padding: new EdgeInsets.only(right: 4),
          ),
          new Text(
            widget.itemTileViewModel.status,
            style: new TextStyle(
                fontSize: 14,
                color: Color(0xFF000000),
                fontWeight: FontWeight.w600),
          ),
        ],
      );
    }
  }

  Color retornarCorStatus() {
    switch (widget.itemTileViewModel.status.toUpperCase()) {
      case "LIDO":
        return Colors.green;
      case "NÃO LIDO":
        return Colors.red;
      case "EM ANDAMENTO":
        return Colors.yellowAccent;
    }
    return Colors.grey;
  }

  Widget retornarNome() {
    if (widget.itemTileViewModel.nome == null) {
      return new Text(
        'INDICAR NOME',
        style: new TextStyle(
            fontSize: 14,
            color: new Color(0xFF000000),
            fontWeight: FontWeight.w600),
      );
    } else {
      return new Text(
        widget.itemTileViewModel.nome,
        style: new TextStyle(
            fontSize: 14,
            color: new Color(0xFF000000),
            fontWeight: FontWeight.w600),
      );
    }
  }

  Widget retornarDataAdmissao() {
    if (widget.itemTileViewModel.dataAdmissao == null) {
      return new Text(
        'INDICAR DATA',
        style: new TextStyle(
            fontSize: 14,
            color: new Color(0xFF000000),
            fontWeight: FontWeight.w600),
      );
    } else {
      return new Text(
        widget.itemTileViewModel.dataAdmissao,
        style: new TextStyle(color: new Color(0xFF808080), fontSize: 12),
      );
    }
  }

  Widget retornarPrazo() {
    if (widget.itemTileViewModel.prazo == null) {
      return new Text(
        'INDICAR PRAZO',
        style: new TextStyle(color: new Color(0xFF808080), fontSize: 12),
      );
    } else {
      return new Text(
        widget.itemTileViewModel.prazo,
        style: new TextStyle(color: new Color(0xFF808080), fontSize: 12),
      );
    }
  }

  Widget retornarCargo() {
    if (widget.itemTileViewModel.cargo == null) {
      return new Text(
        'INDICAR CARGO',
        style: new TextStyle(color: new Color(0xFF808080), fontSize: 12),
      );
    } else {
      return new Text(
        widget.itemTileViewModel.cargo,
        style: new TextStyle(color: new Color(0xFF808080), fontSize: 12),
      );
    }
  }

  Widget retornarPorcentagem() {
    if (widget.itemTileViewModel.porcentagemPreenchimento == null) {
      return new Text(
        'INDICAR PORCENTAGEM',
        style: new TextStyle(
            fontSize: 14,
            color: new Color(0xFF000000),
            fontWeight: FontWeight.w600),
      );
    } else {
      return new Text(
        widget.itemTileViewModel.porcentagemPreenchimento,
        style: new TextStyle(color: new Color(0xFF808080), fontSize: 12),
      );
    }
  }

  Widget _montarSetaDireita() {
    if (widget.onTileIsSelected == null) {
      return new Container();
    } else {
      return new Container(
        child: new Icon(
          Icons.arrow_forward_ios_outlined,
          color: new Color(0XFF2BBAB4),
          size: 18,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: widget.onTileIsSelected,
      child: new IntrinsicHeight(
        child: new Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: new Material(
            elevation: 2,
            color: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(6)),
            child: new Container(
              alignment: Alignment.centerLeft,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  new Expanded(
                      child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Container(
                              margin: const EdgeInsets.only(
                                  left: 8, bottom: 8, top: 4),
                              child: retornarNome()),
                          new Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: retornarStatus()),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Container(
                            margin: const EdgeInsets.only(left: 8, bottom: 4),
                            child: new Text(
                              "Admissão:",
                              style: new TextStyle(
                                  fontSize: 13,
                                  color: new Color(0xFF000000),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          new Container(
                            margin: const EdgeInsets.only(left: 4, bottom: 2),
                            child: retornarDataAdmissao(),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              new Container(
                                margin: const EdgeInsets.only(
                                  left: 8,
                                  bottom: 4,
                                ),
                                child: new Text(
                                  "Cargo:",
                                  style: new TextStyle(
                                      fontSize: 13,
                                      color: new Color(0xFF000000),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(
                                  left: 8,
                                  bottom: 4,
                                ),
                                child: retornarCargo(),
                              ),
                            ],
                          ),
                          new Container(
                            margin: new EdgeInsets.only(right: 8),
                            child: _montarSetaDireita(),
                          )
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              bottom: 4,
                            ),
                            child: new Text(
                              "Preenchimento:",
                              style: new TextStyle(
                                  fontSize: 13,
                                  color: new Color(0xFF000000),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          new Container(
                            margin: new EdgeInsets.only(left: 8, bottom: 2),
                            child: retornarPorcentagem(),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              bottom: 4,
                            ),
                            child: new Text(
                              "Prazo:",
                              style: new TextStyle(
                                  fontSize: 13,
                                  color: new Color(0xFF000000),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          new Container(
                            margin: const EdgeInsets.only(left: 4, bottom: 2),
                            child: retornarPrazo(),
                          ),
                        ],
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

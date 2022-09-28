import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/view-model/item-tile-convite-viewmodel.dart';

enum SelectStatus {
  EM_ANDAMENTO,
  VENCIDO,
  LIDO,
  NAO_LIDO,
  FINALIZADO,
  APROVADO,
}

enum SelecionarEstadoCard { CORRIGIDO, CORRECAO_SOLICITADA }

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
  Widget _retornarStatus() {
    if (widget.itemTileViewModel.status == null) {
      return new Text(
        "INDICAR STATUS",
        style: new TextStyle(
            fontSize: 12,
            color: new Color(0xFF000000),
            fontWeight: FontWeight.w600),
      );
    } else {
      return new Row(
        children: [
          new Container(
            margin: const EdgeInsets.only(right: 2),
            child: widget.itemTileViewModel.icone,
          ),
          new Text(
            widget.itemTileViewModel.status,
            style: new TextStyle(
                fontSize: 14,
                color: new Color(0xFF000000),
                fontWeight: FontWeight.w600),
          ),
        ],
      );
    }
  }

  Widget _retornarNome() {
    if (widget.itemTileViewModel.nome == null) {
      return new Text(
        'INDICAR NOME',
        style: new TextStyle(
            fontSize: 12,
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

  Widget _retornarStateCard() {
    if (widget.itemTileViewModel.stateCard == null) {
      return new Container();
    } else {
      return new Container(
        padding: const EdgeInsets.all(8),
        decoration: new BoxDecoration(
          color: new Color(0XFF2BBAB4),
          borderRadius: new BorderRadius.circular(12),
        ),
        child: new Text(
          "${widget.itemTileViewModel.stateCard}",
          style: new TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  Widget _retornarDataAdmissao() {
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

  Widget _retornarPrazo() {
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

  Widget _retornarCargo() {
    if (widget.itemTileViewModel.cargo == null) {
      return new Text(
        'INDICAR CARGO',
        style: new TextStyle(color: new Color(0xFF808080), fontSize: 12),
      );
    } else {
      return new Text(
        widget.itemTileViewModel.cargo,
        overflow: TextOverflow.ellipsis,
        style: new TextStyle(color: new Color(0xFF808080), fontSize: 12),
      );
    }
  }

  Widget _retornarPorcentagem() {
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
    if (widget.itemTileViewModel.onTileIsSelected == null) {
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
      onTap: widget.itemTileViewModel.onTileIsSelected,
      child: new IntrinsicHeight(
        child: new Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: new Material(
            elevation: 2,
            color: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(6)),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Row(
                      children: [
                        new Container(
                            margin: const EdgeInsets.only(
                                left: 8, bottom: 8, top: 8),
                            child: _retornarNome()),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Container(
                          child: new Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: new Color(0XFF2BBAB4),
                          ),
                          margin: const EdgeInsets.only(left: 8, bottom: 4),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(left: 4, bottom: 4),
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
                          child: _retornarDataAdmissao(),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Container(
                          margin: const EdgeInsets.only(left: 8, bottom: 4),
                          child: new Icon(
                            Icons.work_outline,
                            size: 14,
                            color: new Color(0XFF2BBAB4),
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(
                            left: 4,
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
                        Stack(
                          children: [
                            new Container(
                              width: MediaQuery.of(context).size.width / 3,
                              margin: new EdgeInsets.only(
                                left: 4,
                                bottom: 4,
                              ),
                              child:  _retornarCargo(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Container(
                          margin: const EdgeInsets.only(left: 8, bottom: 4),
                          child: new Icon(
                            Icons.analytics_outlined,
                            size: 14,
                            color: new Color(0XFF2BBAB4),
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(
                            left: 4,
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
                          margin: const EdgeInsets.only(left: 4, bottom: 2),
                          child: _retornarPorcentagem(),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Container(
                          margin: const EdgeInsets.only(left: 8, bottom: 4),
                          child: new Icon(
                            Icons.access_alarm_rounded,
                            size: 14,
                            color: new Color(0XFF2BBAB4),
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(
                            left: 4,
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
                          margin: const EdgeInsets.only(left: 2, bottom: 2),
                          child: _retornarPrazo(),
                        ),
                      ],
                    ),
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    new Container(
                        margin: const EdgeInsets.only(right: 8, top: 8),
                        child: _retornarStatus()),
                    new Container(
                      margin: new EdgeInsets.only(right: 8),
                      child: _montarSetaDireita(),
                    ),
                    new Container(
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                      child: _retornarStateCard(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

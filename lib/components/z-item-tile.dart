import 'package:flutter/material.dart';
import 'package:z_components/api/zcolaborador-service.dart';
import 'package:z_components/components/z-nome-reduzido.dart';
import 'package:z_components/config/z-type-tile.dart';
import 'package:z_components/interface/i-zcolaborador-service.dart';
import 'package:z_components/view-model/colaborador-viewmodel.dart';

class ZItemTile extends StatefulWidget {
  final String idConta;
  final String token;
  final String inicioIntervalo;
  final String voltaIntervalo;
  final String cpf;
  final String codEmpresa;
  final Function onPressedIconBatida;
  final String tempoPausa;
  final String jornada;
  final String telefone;
  final String email;
  final String endereco;
  final String escala;
  final String horaEntrada;
  final String horaSaida;
  final String cargo;
  final String nomeCentroCusto;
  final String nome;
  final String isExpand;
  final String re;
  final Function funcao;
  final Function tabCard;
  final Widget imagemPerfil;
  final String horario;
  final Function onTapImage;
  final Color colorBatida;
  final ZTypeTile zTypeTile;
  final Color colorStatus;
  final String status;

  ZItemTile(
      {this.idConta,
      this.colorStatus = Colors.grey,
      this.re,
      this.tabCard,
      this.horario = "",
      this.inicioIntervalo,
      this.voltaIntervalo,
      this.jornada,
      this.codEmpresa,
      this.onPressedIconBatida,
      this.zTypeTile = ZTypeTile.isColab,
      this.token,
      this.cpf,
      this.colorBatida = Colors.grey,
      this.telefone,
      this.tempoPausa,
      this.endereco,
      this.escala,
      this.horaEntrada,
      this.horaSaida,
      this.cargo,
      this.email,
      this.nomeCentroCusto,
      this.nome,
      this.funcao,
      this.status: "",
      this.imagemPerfil,
      this.onTapImage,
      this.isExpand: ""});

  @override
  _ZItemTileState createState() => _ZItemTileState();
}

class _ZItemTileState extends State<ZItemTile> {
  double _largura;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _largura = MediaQuery.of(context).size.width;
    switch (widget.zTypeTile) {
      case ZTypeTile.isColab:
        return new GestureDetector(
          onTap: widget.tabCard,
          child: IntrinsicHeight(
              child: new Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: new Material(
                      elevation: 2,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      child: new Container(
                        alignment: Alignment.centerLeft,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Expanded(
                              flex: 20,
                              child: new Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xFF808080),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6.0),
                                      bottomLeft: Radius.circular(6.0),
                                    )),
                                child: (widget.imagemPerfil == null)
                                    ? new Icon(
                                        Icons.insert_photo,
                                        color: Color(0xFFffffff),
                                      )
                                    : new Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5.0),
                                              bottomLeft: Radius.circular(5.0)),
                                          color: Colors.transparent,
                                        ),
                                        child: widget.imagemPerfil,
                                      ),
                              ),
                            ),
                            new Expanded(
                                flex: 100,
                                child: new InkWell(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          (widget.isExpand == "isExpand")
                                              ? new Container(
                                                  margin: EdgeInsets.only(
                                                      left: 6.0,
                                                      bottom: 6.0,
                                                      top: 6.0),
                                                  child: (widget.nome == null)
                                                      ? new Text('')
                                                      : new ZNomeReduzido(
                                                          text: widget.nome,
                                                          textStyle: TextStyle(
                                                              fontSize: 14.0,
                                                              color: Color(
                                                                  0xFF000000),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                )
                                              : new Container(
                                                  width: (_largura / 2.0),
                                                  margin: EdgeInsets.only(
                                                      left: 6.0,
                                                      bottom: 6.0,
                                                      top: 6.0),
                                                  child: (widget.nome == null)
                                                      ? new Text('')
                                                      : new ZNomeReduzido(
                                                          text: widget.nome,
                                                          textStyle: TextStyle(
                                                              fontSize: 14.0,
                                                              color: Color(
                                                                  0xFF000000),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                ),
                                          new Container(
                                              //width: (MediaQuery.of(context).size.width / 2.4),
                                              margin: EdgeInsets.only(right: 6),
                                              child: new Text(
                                                widget.re ?? "",
                                                style: new TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                        ],
                                      ),
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Row(
                                            children: <Widget>[
                                              new Container(
                                                margin: EdgeInsets.only(
                                                    left: 6.0,
                                                    right: 0.0,
                                                    bottom: 2.0,
                                                    top: 0.0),
                                                child: new Icon(
                                                  Icons.my_location,
                                                  color: Color(0xFFA3A3A3),
                                                  size: 16.0,
                                                ),
                                              ),
                                              new Container(
                                                width: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.4),
                                                margin: EdgeInsets.only(
                                                    left: 6.0, bottom: 2.0),
                                                child: (widget
                                                            .nomeCentroCusto ==
                                                        null)
                                                    ? new Text('')
                                                    : new Text(
                                                        widget.nomeCentroCusto,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF808080),
                                                            fontSize: 10.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                              ),
                                            ],
                                          ),
                                          new Row(
                                            children: <Widget>[
                                              new Container(
                                                height: 10.0,
                                                width: 10.0,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: (widget.status
                                                                .toLowerCase() ==
                                                            "ativo")
                                                        ? Colors.green
                                                        : (widget.status
                                                                    .toLowerCase() ==
                                                                "inativo")
                                                            ? Colors.red
                                                            : widget
                                                                .colorStatus),
                                              ),
                                              new Container(
                                                margin: EdgeInsets.only(
                                                    right: 8.0, left: 2.0),
                                                child: new Text(
                                                  widget.status,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: const Color(
                                                          0xFF808080)),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new Expanded(
                                            flex: 5,
                                            child: new Container(
                                              width: _largura / 2.3,
                                              child: new Row(
                                                children: <Widget>[
                                                  new Container(
                                                    margin: EdgeInsets.only(
                                                        left: 6.0,
                                                        right: 0.0,
                                                        bottom: 2.0,
                                                        top: 0.0),
                                                    child: new Icon(
                                                      Icons.work,
                                                      size: 16,
                                                      color: Color(0xFFA3A3A3),
                                                    ),
                                                  ),
                                                  new Container(
                                                    width: (_largura < 450)
                                                        ? _largura / 3.5
                                                        : _largura / 3,
                                                    margin: EdgeInsets.only(
                                                        left: 6.0,
                                                        right: 0.0,
                                                        bottom: 2.0,
                                                        top: 0.0),
                                                    child: new Text(
                                                      widget.cargo ?? "",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF808080),
                                                          fontSize: 10.0,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          new Expanded(
                                            flex: 5,
                                            child: new Row(
                                              children: <Widget>[
                                                new Container(
                                                  margin: EdgeInsets.only(
                                                      right: 0.0,
                                                      bottom: 4.0,
                                                      top: 0.0),
                                                  child: new Icon(
                                                    Icons.date_range,
                                                    size: 16,
                                                    color: Color(0xFFA3A3A3),
                                                  ),
                                                ),
                                                new Container(
                                                  width: _largura / 5,
                                                  margin: EdgeInsets.only(
                                                      left: 6.0,
                                                      right: 0.0,
                                                      bottom: 4.0,
                                                      top: 0.0),
                                                  child: new Text(
                                                    widget.escala ?? "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF808080),
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          new Expanded(
                                            flex: 5,
                                            child: new Container(
                                              width: _largura / 2.3,
                                              child: new Row(
                                                children: <Widget>[
                                                  new Container(
                                                    padding: EdgeInsets.only(
                                                        left: 6.0,
                                                        right: 0.0,
                                                        bottom: 6.0,
                                                        top: 0.0),
                                                    child: new Icon(
                                                      Icons.access_time,
                                                      size: 16,
                                                      color: Color(0xFFA3A3A3),
                                                    ),
                                                  ),
                                                  new Container(
                                                    padding: EdgeInsets.only(
                                                        left: 2.0,
                                                        right: 0.0,
                                                        bottom: 6.0,
                                                        top: 0.0),
                                                    child: (widget.horaEntrada ==
                                                                null ||
                                                            widget.horaEntrada ==
                                                                "")
                                                        ? new Text("")
                                                        : new Text(
                                                            widget.horaEntrada ??
                                                                "",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF808080),
                                                                fontSize:
                                                                    (_largura <
                                                                            360)
                                                                        ? 8.0
                                                                        : 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                  ),
                                                  new Container(
                                                    padding: EdgeInsets.only(
                                                        left: 2.0,
                                                        right: 0.0,
                                                        bottom: 6.0,
                                                        top: 0.0),
                                                    child: (widget.horaSaida ==
                                                                null ||
                                                            widget.horaSaida ==
                                                                "")
                                                        ? new Text("")
                                                        : new Text(
                                                            "-${widget.horaSaida}" ??
                                                                "",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF808080),
                                                                fontSize:
                                                                    (_largura <
                                                                            360)
                                                                        ? 8.0
                                                                        : 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                  ),
                                                  new Container(
                                                    padding: EdgeInsets.only(
                                                        left: 6.0,
                                                        right: 0.0,
                                                        bottom: 6.0,
                                                        top: 0.0),
                                                    child: (widget.horario ==
                                                                null ||
                                                            widget.horario ==
                                                                "")
                                                        ? new Text("")
                                                        : new Text(
                                                            "(${widget.horario})",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF808080),
                                                                fontSize:
                                                                    (_largura <
                                                                            360)
                                                                        ? 8.0
                                                                        : 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          new Expanded(
                                            flex: 5,
                                            child: new Container(
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Row(
                                                    children: <Widget>[
                                                      new Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0.0,
                                                                right: 0.0,
                                                                bottom: 6.0,
                                                                top: 0.0),
                                                        child: new Icon(
                                                          Icons.restaurant_menu,
                                                          color:
                                                              Color(0xFFA3A3A3),
                                                          size: 14.0,
                                                        ),
                                                      ),
                                                      new Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 2.0,
                                                                right: 0.0,
                                                                bottom: 6.0,
                                                                top: 0.0),
                                                        child: (widget.inicioIntervalo ==
                                                                    null ||
                                                                widget.inicioIntervalo ==
                                                                    "")
                                                            ? new Text("")
                                                            : new Text(
                                                                widget.inicioIntervalo ??
                                                                    "",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF808080),
                                                                    fontSize: (_largura <
                                                                            360)
                                                                        ? 8.0
                                                                        : 10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                      ),
                                                      new Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 2.0,
                                                                right: 0.0,
                                                                bottom: 6.0,
                                                                top: 0.0),
                                                        child: (widget.voltaIntervalo ==
                                                                    null ||
                                                                widget.voltaIntervalo ==
                                                                    "")
                                                            ? new Text("")
                                                            : new Text(
                                                                "-${widget.voltaIntervalo}" ??
                                                                    "",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF808080),
                                                                    fontSize: (_largura <
                                                                            360)
                                                                        ? 8.0
                                                                        : 10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                      ),
                                                      new Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 2.0,
                                                                right: 0.0,
                                                                bottom: 6.0,
                                                                top: 0.0),
                                                        child: (widget.tempoPausa ==
                                                                    null ||
                                                                widget.tempoPausa ==
                                                                    "")
                                                            ? new Text("")
                                                            : new Text(
                                                                "(${widget.tempoPausa})" ??
                                                                    "",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF808080),
                                                                    fontSize: (_largura <
                                                                            360)
                                                                        ? 8.0
                                                                        : 10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                      ),
                                                    ],
                                                  ),
                                                  new Container(
                                                    margin: EdgeInsets.only(
                                                        right: 6, bottom: 6),
                                                    alignment:
                                                        Alignment.topCenter,
                                                    //margin:  EdgeInsets.only(left: _largura/40,bottom: 6),
                                                    child: new InkWell(
                                                      onTap: widget
                                                          .onPressedIconBatida,
                                                      child: new Icon(
                                                        Icons.alarm_on,
                                                        color:
                                                            widget.colorBatida,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  onTap: widget.funcao,
                                )),
                            new Container(
                              color: Colors.grey,
                              height: 90.0,
                              width: 0.2,
                            ),
                          ],
                        ),
                      )))),
        );
        break;
      case ZTypeTile.isUser:
        return new GestureDetector(
          onTap: widget.tabCard,
          child: IntrinsicHeight(
              child: new Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: new Material(
                      elevation: 2,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      child: IntrinsicHeight(
                          child: new Container(
                        alignment: Alignment.centerLeft,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Expanded(
                              flex: 20,
                              child: new Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xFF808080),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6.0),
                                      bottomLeft: Radius.circular(6.0),
                                    )),
                                child: (widget.imagemPerfil == null)
                                    ? new Icon(
                                        Icons.insert_photo,
                                        color: Color(0xFFffffff),
                                      )
                                    : new Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5.0),
                                              bottomLeft: Radius.circular(5.0)),
                                          color: Colors.transparent,
                                        ),
                                        child: widget.imagemPerfil,
                                      ),
                              ),
                            ),
                            new Expanded(
                                flex: 100,
                                child: new InkWell(
                                  child: new Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          (widget.isExpand == "isExpand")
                                              ? new Container(
                                                  margin: EdgeInsets.only(
                                                      left: 6.0,
                                                      bottom: 6.0,
                                                      top: 6.0),
                                                  child: (widget.nome == null)
                                                      ? new Text('')
                                                      : new ZNomeReduzido(
                                                          text: widget.nome,
                                                          textStyle: TextStyle(
                                                              fontSize: 14.0,
                                                              color: Color(
                                                                  0xFF000000),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                )
                                              : new Container(
                                                  width: (_largura / 2.4),
                                                  margin: EdgeInsets.only(
                                                      left: 6.0,
                                                      bottom: 6.0,
                                                      top: 6.0),
                                                  child: (widget.nome == null)
                                                      ? new Text('')
                                                      : new ZNomeReduzido(
                                                          text: widget.nome,
                                                          textStyle: TextStyle(
                                                              fontSize: 14.0,
                                                              color: Color(
                                                                  0xFF000000),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                ),
                                          new Container(
                                              //width: (MediaQuery.of(context).size.width / 2.4),
                                              margin: EdgeInsets.only(right: 6),
                                              child: new Text(
                                                widget.cpf ?? "",
                                                style: new TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontSize: 12),
                                              )),
                                        ],
                                      ),
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          new Row(
                                            children: <Widget>[
                                              new Container(
                                                margin: EdgeInsets.only(
                                                    left: 6.0,
                                                    right: 0.0,
                                                    bottom: 4.0,
                                                    top: 0.0),
                                                child: new Icon(
                                                  Icons.phone,
                                                  color: Color(0xFF808080),
                                                  size: 16.0,
                                                ),
                                              ),
                                              new Container(
                                                  width: (_largura < 360)
                                                      ? _largura / 3.4
                                                      : _largura / 3.8,
                                                  margin: EdgeInsets.only(
                                                      left: 6.0, bottom: 4.0),
                                                  child: new Text(
                                                    widget.telefone ?? "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: new TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xFF808080),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                          new Row(
                                            children: <Widget>[
                                              new Container(
                                                margin: EdgeInsets.only(
                                                    right: 0.0,
                                                    left: 4,
                                                    bottom: 4.0,
                                                    top: 0.0),
                                                child: new Icon(
                                                  Icons.alternate_email,
                                                  color: Color(0xFF808080),
                                                  size: 16.0,
                                                ),
                                              ),
                                              new Container(
                                                  width: (_largura <= 450)
                                                      ? _largura * 0.28
                                                      : _largura * 0.38,
                                                  height: 15,
                                                  margin: EdgeInsets.only(
                                                      left: 4.0, bottom: 8.0),
                                                  child: new ListView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      children: <Widget>[
                                                        new Text(
                                                          widget.email ?? "",
                                                          style: new TextStyle(
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xFF808080),
                                                          ),
                                                        )
                                                      ])),
                                            ],
                                          )
                                        ],
                                      ),
                                      new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            margin: EdgeInsets.only(left: 6.0),
                                            child: new Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: Color(0xFF808080),
                                            ),
                                          ),
                                          new Container(
                                              width: (_largura <= 450)
                                                  ? _largura / 1.55
                                                  : _largura / 1.4,
                                              margin: EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 0.0,
                                                  bottom: 6.0,
                                                  top: 0.0),
                                              child: new Text(
                                                widget.endereco ?? "",
                                                style: new TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF808080),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: widget.funcao,
                                )),
                            new Container(
                              color: Colors.grey,
                              height: 90.0,
                              width: 0.2,
                            ),
                          ],
                        ),
                      ))))),
        );
        break;
      case ZTypeTile.isEmpresa:
        return new GestureDetector(
          onTap: widget.tabCard,
          child: IntrinsicHeight(
              child: new Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: new Material(
                      elevation: 2,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      child: new Container(
                        alignment: Alignment.centerLeft,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Expanded(
                                child: new InkWell(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      (widget.isExpand == "isExpand")
                                          ? new Container(
                                              margin: EdgeInsets.only(
                                                  left: 6.0,
                                                  bottom: 6.0,
                                                  top: 6.0),
                                              child: (widget.nome == null)
                                                  ? new Text('')
                                                  : new ZNomeReduzido(
                                                      text: widget.nome,
                                                      textStyle: TextStyle(
                                                          fontSize: 14.0,
                                                          color:
                                                              Color(0xFF000000),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                            )
                                          : new Container(
                                              width: (_largura / 2.0),
                                              margin: EdgeInsets.only(
                                                  left: 8.0,
                                                  bottom: 4.0,
                                                  top: 8.0),
                                              child: (widget.nome == null)
                                                  ? new Text('')
                                                  : new ZNomeReduzido(
                                                      text: widget.nome,
                                                      textStyle: TextStyle(
                                                          fontSize: 14.0,
                                                          color:
                                                              Color(0xFF000000),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                            ),
                                      new Container(
                                          width: (_largura / 4.5),
                                          margin: EdgeInsets.only(right: 4),
                                          child: new Text(
                                            widget.codEmpresa ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: new TextStyle(
                                                color: Color(0xFF000000),
                                                fontSize: 12),
                                          )),
                                    ],
                                  ),
                                  new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          new Container(
                                            margin: EdgeInsets.only(
                                                left: 6.0,
                                                right: 0.0,
                                                bottom: 4.0,
                                                top: 0.0),
                                            child: new Icon(
                                              Icons.my_location,
                                              color: Color(0xFFA3A3A3),
                                              size: 16.0,
                                            ),
                                          ),
                                          new Container(
                                            width: (_largura / 1.55),
                                            margin: EdgeInsets.only(
                                                left: 6.0,
                                                right: 0.0,
                                                bottom: 4.0,
                                                top: 0.0),
                                            child: new Text(
                                              widget.nomeCentroCusto ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color(0xFF808080),
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new Container(
                                            height: 10.0,
                                            width: 10.0,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: (widget.status
                                                            .toLowerCase() ==
                                                        "ativo")
                                                    ? Colors.green
                                                    : (widget.status
                                                                .toLowerCase() ==
                                                            "inativo")
                                                        ? Colors.red
                                                        : widget.colorStatus),
                                          ),
                                          new Container(
                                            margin: EdgeInsets.only(
                                                right: 8.0, left: 2.0),
                                            child: new Text(
                                              widget.status,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color:
                                                      const Color(0xFF808080)),
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
                                            left: 6.0,
                                            right: 0.0,
                                            bottom: 4.0,
                                            top: 0.0),
                                        child: new Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: Color(0xFFA3A3A3),
                                        ),
                                      ),
                                      new Container(
                                        width: (_largura < 450)
                                            ? _largura / 1.4
                                            : _largura / 1.2,
                                        margin: EdgeInsets.only(
                                            left: 6.0,
                                            right: 0.0,
                                            bottom: 4.0,
                                            top: 0.0),
                                        child: new Text(
                                          widget.endereco ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xFF808080),
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          new Container(
                                            padding: EdgeInsets.only(
                                                left: 6.0,
                                                right: 0.0,
                                                bottom: 6.0,
                                                top: 0.0),
                                            child: new Icon(
                                              Icons.work,
                                              size: 16,
                                              color: Color(0xFFA3A3A3),
                                            ),
                                          ),
                                          new Container(
                                            width: (_largura / 1.4),
                                            margin: EdgeInsets.only(
                                                left: 6.0,
                                                right: 0.0,
                                                bottom: 4.0,
                                                top: 0.0),
                                            child: new Text(
                                              widget.cargo ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color(0xFF808080),
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      new Container(
                                        margin: EdgeInsets.only(
                                            right: (_largura < 450) ? 6 : 6,
                                            bottom: 6),
                                        child: new InkWell(
                                          onTap: widget.onPressedIconBatida,
                                          child: new Icon(
                                            Icons.alarm_on,
                                            color: widget.colorBatida,
                                            size: (_largura < 450) ? 14 : 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              onTap: widget.funcao,
                            )),
                            new Container(
                              color: Colors.grey,
                              height: 90.0,
                              width: 0.2,
                            ),
                          ],
                        ),
                      )))),
        );
        break;
    }
    return build(context);
  }
}

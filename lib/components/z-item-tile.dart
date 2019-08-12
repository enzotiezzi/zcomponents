import 'package:flutter/material.dart';
import 'package:z_components/api/zcolaborador-service.dart';
import 'package:z_components/components/z-nome-reduzido.dart';
import 'package:z_components/interface/i-zcolaborador-service.dart';
import 'package:z_components/view-model/colaborador-viewmodel.dart';

class ZItemTile extends StatefulWidget {
  final String idConta;
  final String token;
  final String cpf;
  String isExpand;
  bool status;
  Function funcao;
  Widget imagemPerfil;
  Function onTapImage;

  ZItemTile(
      {this.idConta,
      this.token,
      this.cpf,
      this.funcao,
      this.status: false,
      this.imagemPerfil,
      this.onTapImage,
      this.isExpand: ""});

  @override
  _ZItemTileState createState() => _ZItemTileState();
}

class _ZItemTileState extends State<ZItemTile> {
  ColaboradorViewModel colaboradorViewModel;

  IZColaboradorService _colaboradorService;

  @override
  void initState() {
    super.initState();
    _colaboradorService =
        ZColaboradorService(widget.token, widget.idConta, widget.cpf);

    _buscarInformacaoColaborador();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(
          left: 1.0, right: 1.0, bottom: 0.0, top: 0.0),
      height: 90.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      alignment: Alignment.centerLeft,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Expanded(
              flex: 2,
              child: new GestureDetector(
                onTap: widget.onTapImage,
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
              )),
          new Expanded(
              flex: 8,
              child: new InkWell(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        (widget.isExpand == "isExpand")
                            ? new Container(
                                width:
                                    (MediaQuery.of(context).size.width / 2.1),
                                margin: EdgeInsets.only(
                                    left: 6.0, bottom: 6.0, top: 6.0),
                                child: (colaboradorViewModel == null)
                                    ? new Text('')
                                    : new ZNomeReduzido(
                                        text: colaboradorViewModel.nome,
                                        textStyle: TextStyle(
                                            fontSize: 14.0,
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.w600),
                                      ),
                              )
                            : new Container(
                                width:
                                    (MediaQuery.of(context).size.width / 2.0),
                                margin: EdgeInsets.only(
                                    left: 8.0, bottom: 4.0, top: 8.0),
                                child: (colaboradorViewModel == null)
                                    ? new Text('')
                                    : new ZNomeReduzido(
                                        text: colaboradorViewModel.nome,
                                        textStyle: TextStyle(
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
                                  left: 6.0, right: 0.0, bottom: 4.0, top: 0.0),
                              child: new Icon(
                                Icons.my_location,
                                color: Color(0xFFA3A3A3),
                                size: 16.0,
                              ),
                            ),
                            new Container(
                              width: (MediaQuery.of(context).size.width / 2.4),
                              margin: EdgeInsets.only(left: 6.0, right: 0.0, bottom: 4.0, top: 0.0),
                              child: (colaboradorViewModel == null)
                                  ? new Text('')
                                  : new Text(
                                      colaboradorViewModel.nomeCentroCusto,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF808080),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                            ),
                          ],
                        ),
                        (widget.status == true)
                            ? new Row(
                                children: <Widget>[
                                  new Container(
                                    height: 10.0,
                                    width: 10.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xff1AC15D)),
                                  ),
                                  new Container(
                                    margin:
                                        EdgeInsets.only(right: 8.0, left: 2.0),
                                    child: new Text(
                                      "Ativo",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: const Color(0xff999999)),
                                    ),
                                  )
                                ],
                              )
                            : new Row(
                                children: <Widget>[
                                  new Container(
                                    height: 10.0,
                                    width: 10.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xff999999)),
                                  ),
                                  new Container(
                                    margin:
                                        EdgeInsets.only(right: 8.0, left: 2.0),
                                    child: new Text(
                                      "Inativo",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: const Color(0xFF808080)),
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
                              left: 6.0, right: 0.0, bottom: 4.0, top: 0.0),
                          child: new Icon(
                            Icons.work,
                            size: 16,
                            color: Color(0xFFA3A3A3),
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(left: 6.0, right: 0.0, bottom: 4.0, top: 0.0),
                          child: (colaboradorViewModel == null)
                              ? new Text('')
                              : new Text(
                                  colaboradorViewModel.cargo,
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
                          padding: EdgeInsets.only(left: 6.0, right: 0.0, bottom: 6.0, top: 0.0),
                          child: new Icon(
                            Icons.access_time,
                            size: 16,
                            color: Color(0xFFA3A3A3),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(left: 6.0, right: 0.0, bottom: 6.0, top: 0.0),
                          child: (colaboradorViewModel == null)
                              ? new Text('')
                              : new Text(
                                  "${colaboradorViewModel.escala} ${colaboradorViewModel.horaEntrada} - ${colaboradorViewModel.horaSaida}",
                                  style: TextStyle(
                                      color: Color(0xFF808080),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(left: 4.0, right: 0.0, bottom: 6.0, top: 0.0),
                          child: new Text(
                            "(",
                            style: TextStyle(
                                color: Color(0xFF808080),
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 6.0, top: 0.0),
                          child: new Icon(
                            Icons.restaurant_menu,
                            color: Color(0xFFA3A3A3),
                            size: 14.0,
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(left: 2.0, right: 0.0, bottom: 6.0, top: 0.0),
                          child: (colaboradorViewModel == null)
                              ? new Text(
                                  "",
                                  style: TextStyle(
                                      color: Color(0xFF808080),
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w600),
                                )
                              : new Text(
                                  "${colaboradorViewModel.tempoPausa}",
                                  style: TextStyle(
                                      color: Color(0xFF808080),
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 6.0, top: 0.0),
                          child: new Text(
                            ")",
                            style: TextStyle(
                                color: Color(0xFF808080),
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                onTap: widget.funcao,
              )),
          new Container(color: Colors.grey,
            height: 90.0,
            width: 0.2,
          ),
        ],
      ),
    );
  }

  Future _buscarInformacaoColaborador() async {
    var colaborador = await _colaboradorService.buscarPerfilColaborador();

    setState(() {
      colaboradorViewModel = colaborador;
    });
  }
}

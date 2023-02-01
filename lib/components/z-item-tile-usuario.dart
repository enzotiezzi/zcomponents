import 'package:flutter/material.dart';
import 'package:z_components/api/zcolaborador-service.dart';
import 'package:z_components/components/z-injector/z-injector.dart';
import 'package:z_components/interface/i-zcolaborador-service.dart';
import 'package:z_components/view-model/colaborador-viewmodel.dart';
import 'package:z_components/view-model/usuario-viewmodel.dart';

class ZItemTileUsuario extends StatefulWidget {
  final String? idConta;
  final String? token;
  final Color? colorStatus;
  final String? cpf;
  final String? status;
  final String? isExpand;
  final Function? funcao;
  final Widget? imagemPerfil;
  final Function? onTapImage;

  ZItemTileUsuario(
      {this.idConta,
      this.colorStatus = Colors.grey,
      this.token,
      this.cpf,
      this.funcao,
      this.status = "",
      this.imagemPerfil,
      this.onTapImage,
      this.isExpand: ""});

  @override
  _ZItemTileUsuarioState createState() => _ZItemTileUsuarioState();
}

class _ZItemTileUsuarioState extends State<ZItemTileUsuario> {
  ColaboradorViewModel? colaboradorViewModel = ColaboradorViewModel();
  UsuarioViewModel? usuarioViewModel = UsuarioViewModel();
  IZColaboradorService? _colaboradorService = ZInjector.getDependency<IZColaboradorService>();

  @override
  void initState() {
    super.initState();
    _colaboradorService =
        ZColaboradorService(widget.token!, widget.idConta!, widget.cpf!);

    _buscarInformacaoUsuario();
  }

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
              child: new GestureDetector(
                onTap: (){
                  if(widget.onTapImage != null){
                    widget.onTapImage!();
                  }
                },
                child: new Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xFFCECECE),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0))),
                  height: 105.0,
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
                            color: Colors.white,
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
                                    left: 8.0, bottom: 4.0, top: 8.0),
                                child: (colaboradorViewModel == null)
                                    ? new Text('')
                                    : new Text(
                                        colaboradorViewModel!.nome!,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                              )
                            : new Container(
                                width:
                                    (MediaQuery.of(context).size.width / 2.0),
                                margin: EdgeInsets.only(
                                    left: 8.0, bottom: 4.0, top: 8.0),
                                child: (colaboradorViewModel == null)
                                    ? new Text('')
                                    : new Text(
                                        colaboradorViewModel!.nome!,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
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
                                  left: 8.0, right: 4.0, bottom: 4.0),
                              child: new Icon(
                                Icons.my_location,
                                color: Color(0xFFA3A3A3),
                                size: 20.0,
                              ),
                            ),
                            new Container(
                              width: (MediaQuery.of(context).size.width / 2.3),
                              margin: EdgeInsets.only(right: 3.0, bottom: 4.0),
                              child: (colaboradorViewModel == null)
                                  ? new Text('')
                                  : new Text(
                                      colaboradorViewModel!.nomeCentroCusto!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFFA3A3A3),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal),
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
                                  color:
                                      (widget.status!.toLowerCase() == "ativo")
                                          ? Colors.green
                                          : (widget.status!.toLowerCase() ==
                                                  "inativo")
                                              ? Colors.red
                                              : widget.colorStatus),
                            ),
                            new Container(
                              margin: EdgeInsets.only(right: 8.0, left: 2.0),
                              child: new Text(
                                widget.status ?? "",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: const Color(0xff999999)),
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
                              left: 8.0, right: 4.0, bottom: 4.0),
                          child: new Icon(
                            Icons.work,
                            size: 20,
                            color: Color(0xFFA3A3A3),
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(right: 3.0, bottom: 4.0),
                          child: (colaboradorViewModel == null)
                              ? new Text('')
                              : new Text(
                                  colaboradorViewModel!.cargo!,
                                  style: TextStyle(
                                      color: Color(0xFFA3A3A3),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal),
                                ),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.only(bottom: 8.0, left: 8.0),
                          child: new Icon(
                            Icons.access_time,
                            size: 20,
                            color: Color(0xFFA3A3A3),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
                          child: (colaboradorViewModel == null)
                              ? new Text('')
                              : new Text(
                                  "${colaboradorViewModel!.escala} ${colaboradorViewModel!.horaEntrada} - ${colaboradorViewModel!.horaSaida}",
                                  style: TextStyle(
                                      color: Color(0xFFA3A3A3),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700),
                                ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
                          child: new Text(
                            "(",
                            style: TextStyle(
                                color: Color(0xFFA3A3A3),
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: new Icon(
                            Icons.restaurant_menu,
                            color: Color(0xFFA3A3A3),
                            size: 14.0,
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(bottom: 8.0, left: 2.0),
                          child: (colaboradorViewModel == null)
                              ? new Text(
                                  ")",
                                  style: TextStyle(
                                      color: Color(0xFFA3A3A3),
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w500),
                                )
                              : new Text(
                                  "${colaboradorViewModel!.tempoPausa})",
                                  style: TextStyle(
                                      color: Color(0xFFA3A3A3),
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                      ],
                    )
                  ],
                ),
                onTap: (){
                  if(widget.funcao != null){
                    widget.funcao!();
                  }
                },
              )),
        ],
      ),
    );
  }

  Future _buscarInformacaoUsuario() async {
    var colaborador = await _colaboradorService?.buscarPerfilColaborador();

    setState(() {
      colaboradorViewModel = colaborador;
    });
  }
}

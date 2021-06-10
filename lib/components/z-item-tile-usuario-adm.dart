import 'package:flutter/material.dart';
import 'package:z_components/components/z-nome-reduzido.dart';
import 'package:z_components/view-model/conta.dart';

class ZItemTileUsuarioAdm extends StatefulWidget {
  final String nomeUsuario;
  final String appsVinculados;
  final String email;
  final String status;
  final String quantidadeApps;
  final Function onTap;
  final String telefone;
  final bool visibilidade;

  ZItemTileUsuarioAdm(
      {this.nomeUsuario,
      this.appsVinculados,
      this.email,
      this.status,
      this.quantidadeApps,
      this.onTap,
      this.telefone,
      this.visibilidade = false});

  @override
  _ZItemTileUsuarioAdmState createState() => _ZItemTileUsuarioAdmState();
}

class _ZItemTileUsuarioAdmState extends State<ZItemTileUsuarioAdm> {
  Widget retornarNome() {
    if (widget.nomeUsuario == null) {
      return new Text(widget.nomeUsuario);
    } else {
      return new Text(
        widget.nomeUsuario,
        style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600),
      );
    }
  }

  Widget _buildPossuiApps() {
    if (widget.quantidadeApps.isNotEmpty || widget.appsVinculados.isNotEmpty) {
      return new Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
          flex: 20,
          child: new Container(
              margin:
                  EdgeInsets.only(left: 9.0, right: 0.0, bottom: 4.0, top: 6.0),
              child: new Text("Apps:")),
        ),
        Expanded(
          flex: 25,
          child: new Container(
            margin: EdgeInsets.only(
              left: 4.0,
            ),
            child: retotnarAppVinculado(),
          ),
        )
      ]);
    } else {
      return new Container();
    }
  }

  Widget retotnarAppVinculado() {
    if (widget.appsVinculados == null) {
      return new Text('');
    } else {
      if (widget.quantidadeApps == null || widget.quantidadeApps.isEmpty) {
        return new Text(
          widget.appsVinculados,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
          ),
        );
      } else {
        return new Text(
          "[${widget.quantidadeApps}] " + widget.appsVinculados,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
          ),
        );
      }
    }
  }

  Widget retornarEmail() {
    if (widget.email == null) {
      return Text('');
    } else {
      return Text(
        widget.email,
        style: TextStyle(
          color: Color(0xFF000000),
          fontSize: 12,
        ),
      );
    }
  }

  Widget retornarTelefone() {
    if (widget.telefone == null || widget.telefone.isEmpty) {
      return Text('Não possui telefone',
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
          ));
    } else {
      return Text(
        widget.telefone,
        style: TextStyle(
          color: Color(0xFF000000),
          fontSize: 12,
        ),
      );
    }
  }

  Widget retornarStatus() {
    if (widget.status == null) {
      return Text('');
    } else {
      return Text(
        widget.status,
        style: TextStyle(
          color: Color(0xFF000000),
          fontSize: 12,
        ),
      );
    }
  }

  Widget _retornarArrow() {
    if (widget.visibilidade) {
      return Container();
    } else {
      return Expanded(
        flex: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: new IntrinsicHeight(
        child: new Container(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 7, top: 7),
          child: Material(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Container(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 7, right: 7),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new Container(
                                margin: EdgeInsets.only(
                                    left: 9.0, bottom: 6.0, top: 6.0),
                                child: retornarNome()),
                          ],
                        ),
                        _buildPossuiApps(),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 20,
                              child: new Container(
                                  margin: EdgeInsets.only(
                                      left: 9.0,
                                      right: 0.0,
                                      bottom: 4.0,
                                      top: 6.0),
                                  child: new Text("E-mail:")),
                            ),
                            Expanded(
                              flex: 25,
                              child: new Container(
                                margin: EdgeInsets.only(
                                  left: 4.0,
                                ),
                                child: retornarEmail(),
                              ),
                            ),
                          ],
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 20,
                              child: new Container(
                                  margin: EdgeInsets.only(
                                      left: 9.0,
                                      right: 0.0,
                                      bottom: 4.0,
                                      top: 6.0),
                                  child: new Text("Telefone:")),
                            ),
                            Expanded(
                              flex: 25,
                              child: new Container(
                                margin: EdgeInsets.only(
                                  left: 4.0,
                                ),
                                child: retornarTelefone(),
                              ),
                            ),
                          ],
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 20,
                              child: new Container(
                                  margin: EdgeInsets.only(
                                      left: 9.0,
                                      right: 0.0,
                                      bottom: 4.0,
                                      top: 6.0),
                                  child: new Text("Status:")),
                            ),
                            Expanded(
                              flex: 25,
                              child: new Container(
                                margin: EdgeInsets.only(
                                  left: 4.0,
                                ),
                                child: retornarStatus(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _retornarArrow()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ZItemTileModuloAdm extends StatefulWidget {

  final String nomeModulo;
  final String perfilAcesso;
  final String statusVinculo;
  final String dataVinculo;
  final String dataExpiracao;
  final Function onTap;
  final bool visibilidade;

  ZItemTileModuloAdm(
      {this.nomeModulo,
        this.perfilAcesso,
        this.statusVinculo,
        this.dataVinculo,
        this.dataExpiracao,
        this.onTap,
        this.visibilidade=false}
        );

  @override
  _ZItemTileModuloAdmState createState() => _ZItemTileModuloAdmState();
}

class _ZItemTileModuloAdmState extends State<ZItemTileModuloAdm> {

  Widget retornarNomeModulo(){
    if(widget.nomeModulo==null){
      return new Text(widget.nomeModulo);
    }else{
      return new Text(
        widget.nomeModulo,
        style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600
        ),
      );
    }
  }

  Widget retotnarPerfilAcesso (){
    if(widget.perfilAcesso == null){
      return new Text('');
    }else{
      return new Text(
        widget.perfilAcesso,
        style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
        ),
      );
    }
  }

  Widget retornarDataExpiracao(){
    if(widget.dataExpiracao==null){
      return Text('');
    }else{
      return Text(
        widget.dataExpiracao,
        style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
        ),
      );
    }
  }

  Widget retornarDataVinculo(){
    if(widget.dataVinculo==null){
      return Text('');
    }else{
      return Text(
        widget.dataVinculo,
        style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
        ),
      );
    }
  }

  Widget retornarStatusVinculo(){
    if(widget.statusVinculo==null){
      return Text('');
    }else{
      return Text(
        widget.statusVinculo,
        style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
        ),
      );
    }
  }

  Widget _retornarArrow(){
    if(widget.visibilidade){
      return Container();
    }else{
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
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Material(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),),
            child: Container(
              padding: const EdgeInsets.only(top: 8,bottom: 8,left: 7,right: 7),
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
                                child: retornarNomeModulo()
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
                                      left: 9.0, right: 0.0, bottom: 4.0, top: 6.0),
                                  child: new Text(
                                      "Perfil:"
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 25,
                              child: new Container(
                                margin: EdgeInsets.only(left: 4.0,),
                                child: retotnarPerfilAcesso(),
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
                                      left: 9.0, right: 0.0, bottom: 4.0, top: 6.0),
                                  child: new Text(
                                      "Status:"
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 25,
                              child: new Container(
                                margin: EdgeInsets.only(left: 4.0,),
                                child: retornarStatusVinculo(),
                              ),
                            ),
                          ],
                        ),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex:20,
                              child: new Container(
                                  margin: EdgeInsets.only(
                                      left: 9.0, right: 0.0, bottom: 4.0, top: 6.0),
                                  child: new Text(
                                      "Data de expiração:"
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 25,
                              child: new Container(
                                margin: EdgeInsets.only(left: 4.0,),
                                child: retornarDataExpiracao(),
                              ),
                            ),
                          ],
                        ),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex:20,
                              child: new Container(
                                  margin: EdgeInsets.only(
                                      left: 9.0, right: 0.0, bottom: 4.0, top: 6.0),
                                  child: new Text(
                                      "Data de vínculo:"
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 25,
                              child: new Container(
                                margin: EdgeInsets.only(left: 4.0,),
                                child: retornarDataVinculo(),
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

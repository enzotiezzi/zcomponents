import 'package:flutter/material.dart';

class ZItemTileModuloAdm extends StatefulWidget {

  final String nomeModulo;
  final String perfilAcesso;
  final String statusVinculo;
  final String dataVinculo;
  final String dataExpiracao;
  final Function onTap;

  ZItemTileModuloAdm(
      {this.nomeModulo,
        this.perfilAcesso,
        this.statusVinculo,
        this.dataVinculo,
        this.dataExpiracao,
        this.onTap}
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
            fontWeight: FontWeight.w600
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
            fontWeight: FontWeight.w600
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
            fontWeight: FontWeight.w600
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
            fontWeight: FontWeight.w600
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new IntrinsicHeight(
      child: GestureDetector(
        onTap: widget.onTap,
        child: new Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: new Material(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: new Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new Row(
                        children: [
                          new Container(
                              margin: EdgeInsets.only(
                                  left: 9.0,
                                  bottom: 6.0,
                                  top: 6.0),
                              child: retornarNomeModulo()
                          ),
                        ],
                      ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          new Container(
                            margin: EdgeInsets.only(
                                left: 9.0,
                                bottom: 6.0,
                                top: 6.0),
                            child: retotnarPerfilAcesso(),
                            width: 280,
                          ),
                        ],
                      ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Container(
                              margin: EdgeInsets.only(
                                  left: 9.0,
                                  bottom: 6.0,
                                  top: 6.0),
                              child: retornarStatusVinculo()
                          ),

                        ],
                      ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Container(
                              margin: EdgeInsets.only(
                                  left: 9.0,
                                  bottom: 6.0,
                                  top: 6.0),
                              child: retornarDataExpiracao()
                          ),
                        ],
                      ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Container(
                              margin: EdgeInsets.only(
                                  left: 9.0,
                                  bottom: 6.0,
                                  top: 6.0),
                              child: retornarDataVinculo()
                          ),
                        ],
                      ),

                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                            Icons.arrow_forward_ios_outlined
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

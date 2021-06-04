import 'package:flutter/material.dart';

class ZItemTileModuloGestao extends StatefulWidget {
  final Function onTap;
  final String nomeModulo;
  final String status;
  final bool visibilidade;

  ZItemTileModuloGestao({this.onTap,this.nomeModulo,this.status,this.visibilidade=false});

  @override
  _ZItemTileModuloGestaoState createState() => _ZItemTileModuloGestaoState();
}

class _ZItemTileModuloGestaoState extends State<ZItemTileModuloGestao> {

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

  Widget retornarStatusVinculo(){
    if(widget.status==null){
      return Text('');
    }else{
      return Text(
        widget.status,
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
      child: IntrinsicHeight(
        child: Container(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 7,top: 7),
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
                        Row(
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
                                      "Status:"
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 35,
                              child: new Container(
                                margin: EdgeInsets.only(left: 4.0,),
                                child: retornarStatusVinculo(),
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

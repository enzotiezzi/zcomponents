import 'package:flutter/material.dart';
import 'package:z_components/components/z-nome-reduzido.dart';

class ZItemTileUsuarioAdm extends StatefulWidget {

  final String nomeUsuario;
  final String appsVinculados;
  final String email;
  final String status;
  final String quantidadeApps;
  Function onTap;

  ZItemTileUsuarioAdm(
      {this.nomeUsuario,
        this.appsVinculados,
        this.email,
        this.status,
        this.quantidadeApps,
        this.onTap
      });

  @override
  _ZItemTileUsuarioAdmState createState() => _ZItemTileUsuarioAdmState();
}

class _ZItemTileUsuarioAdmState extends State<ZItemTileUsuarioAdm> {

  Widget retornarNome(){
    if(widget.nomeUsuario==null){
      return new Text(widget.nomeUsuario);
    }else{
      return new Text(
        widget.nomeUsuario,
        style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600
        ),
      );
    }
  }

  Widget retornarAppVinculado (){
    if(widget.appsVinculados == null){
      return new Text('');
    }else{
      return new Text(
        "[${widget.quantidadeApps}] " +widget.appsVinculados,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
            fontWeight: FontWeight.w600
        ),
      );
    }
  }

  Widget retornarEmail(){
    if(widget.email==null){
      return Text('');
    }else{
      return Text(
        widget.email,
        style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
            fontWeight: FontWeight.w600
        ),
      );
    }
  }

  Widget retornarStatus(){
    if(widget.status==null){
      return Text('');
    }else{
      return Text(
        widget.status,
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
                              child: retornarNome()
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
                              child: retornarAppVinculado(),
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
                              child: retornarEmail()
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
                              child: retornarStatus()
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

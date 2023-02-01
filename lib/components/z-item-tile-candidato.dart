import 'package:flutter/material.dart';
import 'package:z_components/components/z-nome-reduzido.dart';

class ZItemTileCandidato extends StatefulWidget {
  final String? nome;
  final String? funcao;
  final String? email;
  final String? telefone;

  ZItemTileCandidato({this.nome, this.telefone, this.funcao, this.email});

  @override
  _ZItemTileCandidatoState createState() => _ZItemTileCandidatoState();
}

class _ZItemTileCandidatoState extends State<ZItemTileCandidato> {

  Widget retornarNome(){
    if(widget.nome==null){
      return new Text('');
    }else{
      return new Text(
        widget.nome!,
        style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600
        ),
      );
    }
  }

  Widget retornarFuncao(){
    if(widget.funcao==null){
      return Text('');
    }else{
      return Text(
        widget.funcao!,
        style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
            fontWeight: FontWeight.w700
        ),
      );
    }
  }

  Widget retornarTelefone(){
    if(widget.telefone==null){
      return Text('');
    }else{
      return Text(
        widget.telefone!,
        overflow: TextOverflow.ellipsis,
        style: new TextStyle(
        fontSize: 12,
        color: Color(0xFF808080),
        )
      );
    }
  }

  Widget retornarEmail(){
    if(widget.email==null){
      return Text('');
    }else{
      return Text(
        widget.email!,
        style: TextStyle(
          color: Color(0xFF808080),
          fontSize: 12
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return new IntrinsicHeight(
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
              children: [
                new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new Container(
                              margin: EdgeInsets.only(
                                  left: 9.0,
                                  bottom: 6.0,
                                  top: 6.0),
                              child: retornarNome()
                            ),
                            new Container(
                              margin: EdgeInsets.only(right: 6),
                              child: retornarFuncao()
                            )
                          ],
                        ),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Row(
                              children: [
                                new Container(
                                  margin: EdgeInsets.only(
                                      left: 6.0,
                                      right: 0.0,
                                      bottom: 4.0,
                                      top: 6.0),
                                  child: new Icon(
                                    Icons.alternate_email,
                                    color: Color(0xFF808080),
                                    size: 16.0,
                                  ),
                                ),
                                new Container(
                                  margin: EdgeInsets.only(
                                      left: 4.0, bottom: 4.0),
                                  child: retornarEmail(),
                                ),
                                new Row(
                                  children: [
                                    new Container(),
                                    new Container()
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Row(
                              children: [
                                new Container(
                                  margin: EdgeInsets.only(
                                      left: 6.0,
                                      right: 0.0,
                                      bottom: 4.0,
                                      top: 6.0),
                                  child: new Icon(
                                    Icons.phone,
                                    color: Color(0xFF808080),
                                    size: 16.0,
                                  ),
                                ),
                                new Container(
                                  margin: EdgeInsets.only(
                                      left: 4.0, bottom: 4.0),
                                  child: retornarTelefone(),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

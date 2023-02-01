import 'package:flutter/material.dart';

class ZItemTileCardBasico extends StatefulWidget {
  final Function? onTap;
  final String? nome;

  final bool visibilidade;

  ZItemTileCardBasico(
      {this.onTap, this.nome, this.visibilidade = false});

  @override
  _ZItemTileCardBasicoState createState() => _ZItemTileCardBasicoState();
}

class _ZItemTileCardBasicoState extends State<ZItemTileCardBasico> {
  Widget retornarNomeModulo() {
    if (widget.nome == null) {
      return new Text("");
    } else {
      return new Text(
        widget.nome!,
        style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600),
      );
    }
  }

  Widget _retornarArrow() {
    if (widget.visibilidade) {
      return Container();
    } else {
      return Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_forward_ios_outlined, color:Theme.of(context).primaryColor,),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(widget.onTap!=null){
          widget.onTap!();
        }
      },
      child: IntrinsicHeight(
        child: Container(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 7,top: 7),
          child: Material(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
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
                                child: retornarNomeModulo()),
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

import 'package:flutter/material.dart';

class ZItemTilePerguntaAdicional extends StatefulWidget {
  final Function onPressed;
  String textoPergunta;
  String tipoPergunta;
  List<String> opcoes;

  ZItemTilePerguntaAdicional(
      {this.onPressed, this.tipoPergunta, this.opcoes, this.textoPergunta});

  @override
  _ZItemTilePerguntaAdicionalState createState() =>
      _ZItemTilePerguntaAdicionalState();
}

class _ZItemTilePerguntaAdicionalState
    extends State<ZItemTilePerguntaAdicional> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: widget.onPressed,
      child: new IntrinsicHeight(
        child: new Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: new Material(
            elevation: 2,
            color: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(6)),
            child: new Container(
              alignment: Alignment.centerLeft,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  new Expanded(
                      flex: 9,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Container(
                            margin: EdgeInsets.only(top: 8, bottom: 4, left: 8),
                            child: retornarNomePergunta(),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              new Container(
                                margin:
                                    const EdgeInsets.only(left: 8, bottom: 4),
                                child: new Text(
                                  "Tipo de Pergunta:",
                                  style: new TextStyle(
                                      fontSize: 13,
                                      color: new Color(0xFF000000),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              new Container(
                                margin:
                                    const EdgeInsets.only(left: 4, bottom: 2),
                                child: retornarTipoPergunta(),
                              ),
                            ],
                          ),
                          retornarOpcoes(),
                        ],
                      )),
                  new Expanded(flex: 1, child: _montarSetaDireita())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget retornarNomePergunta() {
    if (widget.textoPergunta == null) {
      return new Text(
        'Sem Pergunta',
        style: new TextStyle(
            fontSize: 12,
            color: new Color(0xFF000000),
            fontWeight: FontWeight.w600),
      );
    } else {
      return new Text(
        widget.textoPergunta,
        overflow: TextOverflow.ellipsis,
        style: new TextStyle(
            fontSize: 14,
            color: new Color(0xFF000000),
            fontWeight: FontWeight.w600),
      );
    }
  }

  Widget retornarTipoPergunta() {
    if (widget.tipoPergunta == null) {
      return new Text(
        'Sem tipo de pergunta',
        style: new TextStyle(
            fontSize: 14,
            color: new Color(0xFF000000),
            fontWeight: FontWeight.w600),
      );
    } else {
      return new Text(
        widget.tipoPergunta,
        style: new TextStyle(color: new Color(0xFF808080), fontSize: 12),
      );
    }
  }

  Widget retornarOpcoes() {
    if (widget.opcoes == null) {
      return new Container();
    } else {
      String textoOpcoes = "";
      for (int i = 0; i < widget.opcoes.length; i++) {
        if (i != widget.opcoes.length - 1)
          textoOpcoes = "$textoOpcoes ${widget.opcoes[i]} -";
        else
          textoOpcoes = "$textoOpcoes ${widget.opcoes[i]}";
      }

      return new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new Container(
            margin: const EdgeInsets.only(
              left: 8,
              bottom: 8,
            ),
            child: new Text(
              "Opções:",
              style: new TextStyle(
                  fontSize: 13,
                  color: new Color(0xFF000000),
                  fontWeight: FontWeight.w600),
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width / 1.6,
            margin: const EdgeInsets.only(left: 2, bottom: 8),
            child: new Text(
              textoOpcoes,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(color: new Color(0xFF808080), fontSize: 12),
            ),
          ),
        ],
      );
    }
  }

  Widget _montarSetaDireita() {
    if (widget.onPressed == null) {
      return new Container();
    } else {
      return new Container(
        child: new Icon(
          Icons.arrow_forward_ios_outlined,
          color: new Color(0XFF2BBAB4),
          size: 18,
        ),
      );
    }
  }
}

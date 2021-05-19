import 'package:flutter/material.dart';
import 'package:z_components/components/z-nome-reduzido.dart';

class ZItemTileListaCandidato extends StatefulWidget {

  final String idConta;
  final Widget imagemPerfil;
  final String nomeDependente;
  final String idade;
  final String grauParentesco;
  final String documentos;

  ZItemTileListaCandidato(
      {this.idConta,
        this.imagemPerfil,
        this.nomeDependente,
        this.idade,
        this.documentos,
        this.grauParentesco
      });

  @override
  _ZItemTileListaCandidatoState createState() => _ZItemTileListaCandidatoState();
}

class _ZItemTileListaCandidatoState extends State<ZItemTileListaCandidato> {

  Widget retornarImagem(){
    if(widget.imagemPerfil == null){
      return new Icon(
        Icons.insert_photo,
        color: Color(0xFFffffff),
      );
    }else{
      return new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              bottomLeft: Radius.circular(5.0)),
          color: Colors.transparent,
        ),
        child: widget.imagemPerfil,
      );
    }
  }

  Widget retornarNome(){
    if(widget.nomeDependente==null){
      return new Text('');
    }else{
      return new ZNomeReduzido(
        text: widget.nomeDependente,
        textStyle: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600
        ),
      );
    }
  }

  Widget retornarIdade(){
    if(widget.idade==null){
      return new Text('');
    }else{
      return new Text(
        "${widget.idade}  anos",
        style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
            fontWeight: FontWeight.w700
        ),
      );
    }
  }

  Widget retornarGrauParentesco(){
    if(widget.grauParentesco == null){
      return new Text('');
    }else{
      return new Text(
        widget.grauParentesco,
        style: TextStyle(
          color: Color(0xFF000000),
          fontSize: 12,
          fontWeight: FontWeight.w700
        ),
      );
    }
  }

  Widget retornarNomesDocumentos(){
    if(widget.documentos == null){
      return new Text('');
    }else{
      return new Text(
        widget.documentos,
        style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
            fontWeight: FontWeight.w700
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
          //elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)),
            child: new Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  new Expanded(
                    flex: 20,
                    child: new Container(
                      margin: const EdgeInsets.only(left: 4, right: 4, bottom: 4,top: 4),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFF808080),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                      ),
                      child: retornarImagem(),
                    ),
                  ),
                  new Expanded(
                    flex: 100,
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
                                child: retornarIdade()
                            )
                          ],
                        ),

                        new Row(
                          children: [
                            new Container(
                              margin: EdgeInsets.only(
                                  left: 6.0,
                                  right: 0.0,
                                  bottom: 4.0,
                                  top: 6.0),
                              child: new Icon(
                                Icons.account_tree_outlined,
                                color: Color(0xFF808080),
                                size: 16.0,
                              ),
                            ),
                            new Container(
                              margin: EdgeInsets.only(
                                  left: 4.0, bottom: 4.0),
                              child: retornarGrauParentesco(),
                            ),
                          ],
                        ),


                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Container(
                              margin: EdgeInsets.only(
                                  left: 6.0,
                                  right: 0.0,
                                  bottom: 4.0,
                                  top: 6.0),
                              child: new Icon(
                                Icons.wysiwyg,
                                color: Color(0xFF808080),
                                size: 16.0,
                              ),
                            ),
                            new Container(
                              margin: EdgeInsets.only(
                                  left: 4.0, bottom: 4.0),
                              child: retornarNomesDocumentos(),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}

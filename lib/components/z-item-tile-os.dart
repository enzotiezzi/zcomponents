import 'package:flutter/material.dart';

class ZItemTileOS extends StatefulWidget {

  final String oque;
  final String onde;
  final String porque;
  final String dataSla;
  final String codigo;
  final String prioridade;
  final bool visibilidade;
  final bool emAndamento;
  final Function onPressedFinalizar;
  final Function onTap;

  ZItemTileOS({
    this.oque,
    this.onde,
    this.porque,
    this.codigo,
    this.prioridade,
    this.dataSla,
    this.visibilidade = false,
    this.emAndamento =false,
    this.onPressedFinalizar = null,
    this.onTap
  });

  @override
  _ZItemTileOSState createState() => _ZItemTileOSState();
}

class _ZItemTileOSState extends State<ZItemTileOS> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: widget.onTap,
      child: new IntrinsicHeight(
        child: new Container(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 7,top: 7),
          child: new Material(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),),
            child: new Container(
              padding: const EdgeInsets.only(top: 8,bottom: 8,left: 7,right: 7),
              alignment: Alignment.centerLeft,

              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Expanded(
                    flex: 20,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new Container(
                                margin: EdgeInsets.only(
                                    left: 9.0, bottom: 6.0, top: 6.0),
                                child: retornaCodigo(widget.codigo),
                              ),
                            new Row(
                                children: [
                                  Container(
                                    child: Text("Prioridade: "),
                                  ),
                                  Container(
                                    child: Text("Baixa"),
                                  )
                                ],
                              ),
                          ],
                        ),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 8,
                              child: new Container(
                                  margin: EdgeInsets.only(
                                      left: 9.0, right: 0.0, bottom: 4.0, top: 6.0),
                                  child: new Text(
                                      "Onde:"
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 25,
                              child: new Container(
                                child: retornaOnde(widget.onde),
                              ),
                            ),
                          ],
                        ),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 12,
                              child: new Container(
                                  margin: EdgeInsets.only(
                                      left: 9.0, right: 0.0, bottom: 4.0, top: 6.0),
                                  child: new Text(
                                      "O que:"
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 20,
                              child: new Container(
                                margin: EdgeInsets.only(left: 4.0,),
                                child: retornaOque(widget.oque),
                              ),
                            ),
                            Expanded(
                              flex: 20,
                              child: Container(
                                height: 20,
                                child: retornaBotao()
                              ),
                            ),
                          ],
                        ),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 12,
                              child: new Container(
                                  margin: EdgeInsets.only(
                                      left: 9.0, right: 0.0, bottom: 4.0, top: 6.0),
                                  child: new Text(
                                      "Por que:"
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 40,
                              child: new Container(
                                margin: EdgeInsets.only(left: 4.0,),
                                child: retornaPorque(widget.porque),
                              ),
                            ),
                          ],
                        ),


                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 12,
                              child: new Container(
                                  margin: EdgeInsets.only(
                                      left: 9.0, right: 0.0, bottom: 4.0, top: 6.0),
                                  child: new Text(
                                      "Data SLA:"
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 40,
                              child: new Container(
                                margin: EdgeInsets.only(left: 4.0,),
                                child: retornaDataSla(widget.dataSla),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),



                  Expanded(
                    flex: 3,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: retornaArrow(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget retornaOque (String oque){
    if(oque == null || oque.isEmpty){
      return Text("Motivo não encontrado");
    }else{
      return Text(
        widget.oque,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600
        ),
      );
    }
  }
  Widget retornaOnde (String onde){
    if(onde == null || onde.isEmpty){
      return Text("Local não encontrado",overflow: TextOverflow.ellipsis,);
    }else{
      return Text(
        widget.onde,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600
        ),
      );
    }
  }
  Widget retornaPorque (String porque){
    if(porque == null || porque.isEmpty){
      return Text("Local não encontrado");
    }else{
      return Text(
        widget.porque,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600
        ),
      );
    }
  }
  Widget retornaDataSla (String dataSla){
    if(dataSla ==null || dataSla.isEmpty){
      return new Text("Sem SLA");
    }else{
      return new Text(
        widget.dataSla,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600
        ),
      );
    }
  }
  Widget retornaCodigo (String codigo){
    if (codigo == null || codigo.isEmpty){
      return new Text("Código não identificado");
    }else{
      return Text(
        widget.codigo,
        style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600
        ),
      );
    }
  }
  Widget retornaPrioridade (String prioridade){
    if (prioridade == null || prioridade.isEmpty){
      return new Text("Não têm");
    }else{
      return Text(
        widget.prioridade,
        style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600
        ),
      );
    }
  }
  Widget retornaBotao(){
    if(widget.emAndamento){
      return RaisedButton(
        child: Text("Finalizar"),
        onPressed: widget.onPressedFinalizar,
      );
    }else{
      return Container();
    }
  }
  Widget retornaArrow(){
    if(widget.visibilidade){
      return Container();
    }else{
      return Icon(Icons.arrow_forward_ios_outlined);
    }
  }
}

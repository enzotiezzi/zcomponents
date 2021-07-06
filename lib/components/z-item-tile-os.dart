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
    this.onPressedFinalizar,
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
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8,top: 8),
          child: Material(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),),
            child: new Container(
              padding: const EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 8),
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
                                    left: 8, bottom: 8, top: 8),
                                child: retornaCodigo(widget.codigo)
                            ),
                            new Row(
                              children: [
                                new Container(
                                  child: Text("Prioridade: "),
                                ),
                                new Container(
                                  child: retornaPrioridade(widget.prioridade),
                                )
                              ],
                            ),
                          ],
                        ),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Expanded(
                              flex: flexCampoDescAndamento(),
                              child: new Container(
                                  margin: marginOnde(),
                                  child: new Text(
                                      "Onde:"
                                  )
                              ),
                            ),
                            new Expanded(
                              flex: flexCampoConteudoAndamento(),
                              child: new Container(
                                margin: EdgeInsets.only(left: 0,),
                                child: retornaOnde(widget.onde),
                              ),
                            ),
                            //espacoAdicional()
                          ],
                        ),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Expanded(
                              flex: flexCampoDescAndamento(),
                              child: new Container(
                                  margin: marginOque(),
                                  child: new Text(
                                      "O que:"
                                  )
                              ),
                            ),
                            new Expanded(
                              flex: flexEmAndamento(),
                              child: new Container(
                                margin: EdgeInsets.only(left:0,),
                                child: retornaOque(widget.oque),
                              ),
                            ),
                            retornaBotao()
                          ],
                        ),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Expanded(
                              flex:flexCampoDescAndamento(),
                              child: new Container(
                                  margin: marginPorque(),
                                  child: new Text(
                                      "Por que:"
                              )
                              ),
                            ),
                            new Expanded(
                              flex: flexCampoConteudoAndamento(),
                              child: new Container(
                                margin: EdgeInsets.only(left: 0,),
                                child: retornaPorque(widget.porque),
                              ),
                            ),
                            //espacoAdicional()
                          ],
                        ),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Expanded(
                              flex:flexCampoDescAndamento(),
                              child: new Container(
                                  margin: marginSLA(),
                                  child: new Text(
                                      "Data SLA:"
                                  )
                              ),
                            ),
                            new Expanded(
                              flex: flexCampoConteudoAndamento(),
                              child: new Container(
                                margin: EdgeInsets.only(left: 0,),
                                child: retornaDataSla(widget.dataSla),
                              ),
                            ),
                            //espacoAdicional()
                          ],
                        ),



                      ],
                    ),
                  ),

                  retornaArrow()
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
        widget.oque,overflow: TextOverflow.ellipsis,
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
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600
        ),
      );
    }
  }
  Widget retornaDataSla (String dataSla){
    if(dataSla ==null || dataSla.isEmpty){
      return new  Container(
        margin:EdgeInsets.only(
            top:8
        ),
        child: new Text(
          "Sem SLA",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600
          ),
        ),
      );
    }else{
      return Container(
          margin:EdgeInsets.only(
            top: 8
          ),
        child: new Text(
          widget.dataSla,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600
          ),
        ),
      );
    }
  }
  Widget retornaCodigo (String codigo){
    if (codigo == null || codigo.isEmpty){
      return new Text("Código não identificado");
    }else{
      return Text(
        widget.codigo, overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 12,
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
        widget.prioridade,overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 12,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600
        ),
      );
    }
  }
  Widget retornaBotao(){

    if(widget.emAndamento){
      return  Stack(
        children: [
          GestureDetector(
            onTap: widget.onPressedFinalizar,
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),),
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(0),
                child: Icon(Icons.check,size:32,
                  color: Theme.of(context).primaryColor,),
              ),
            ),
          ),
        ],
    );

    }else{
      return Container();
    }
  }


  int flexEmAndamento(){
    if(widget.emAndamento){
        return 36;
    }else{
      return  25;
    }
  }

  int flexCampoDescAndamento(){
    if(widget.emAndamento){
      return 15;
    }else{
      return  20;
    }
  }

  int flexCampoConteudoAndamento(){
    if(widget.emAndamento){
      return 42;
    }else{
      return  25;
    }
  }

  Widget espacoAdicional(){
    if(widget.emAndamento){
      return Expanded(
        flex: 30,
        child: Container(),
      );
    }else{
      return Container();
    }
  }
  Widget retornaArrow(){
    if(widget.visibilidade){
      return Expanded(flex:5,child: Container());
    }else{
      return Expanded(
        flex: 5,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_forward_ios_outlined, color:Theme.of(context).primaryColor,),
            ],
          ),
        ),
      );
    }
  }

  EdgeInsetsGeometry marginOnde(){
    if(widget.emAndamento){
      return EdgeInsets.only(
          left: 8, right: 0, bottom: 0, top: 0
      );
    }else{
      return
      EdgeInsets.only(
          left: 8, right: 0, bottom: 4, top: 8
      );
    }
  }
  EdgeInsetsGeometry marginOque() {
    if (widget.emAndamento) {
      return EdgeInsets.only(
          left: 8, right: 0, bottom: 8, top: 8
      );
    } else {
      return
      EdgeInsets.only(
          left: 8, right: 0, bottom: 4, top: 8
      );
    }
  }

  EdgeInsetsGeometry marginPorque() {
    if (widget.emAndamento) {
      return EdgeInsets.only(
          left: 8, right: 0, bottom: 0, top: 0
      );
    } else {
      return
      EdgeInsets.only(
          left: 8, right: 0, bottom: 4, top: 8
      );
    }
  }
  EdgeInsetsGeometry marginSLA() {
    if (widget.emAndamento) {
      return EdgeInsets.only(
          left: 8, right: 0, bottom: 2, top:8
      );
    } else {
      return
      EdgeInsets.only(
          left: 8, right: 0, bottom: 0, top: 8
      );
    }
  }


}

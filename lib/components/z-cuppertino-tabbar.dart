import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZCuppertinoTabBar<T> extends StatefulWidget {
  int tabInicial;
  final Color corTabSelecionada;
  final String primeiraTabNome;
  final String segundaTabNome;
  final bool lockPrimeiraTab;
  final bool lockSegundaTab;
  final int porcentagemLarguraTabLocks;
  final ValueChanged<T> trocaDeTabs;

  ZCuppertinoTabBar(
      {this.tabInicial: 0,
        this.corTabSelecionada: const Color(0xff2bbab4),
        this.primeiraTabNome: "Tab1",
        this.segundaTabNome: "Tab2",
        this.lockPrimeiraTab: false,
        this.lockSegundaTab: false,
        this.porcentagemLarguraTabLocks = 82,
        @required this.trocaDeTabs
      });

  @override
  State<StatefulWidget> createState() => _ZCuppertinoTabBarState();
}

class _ZCuppertinoTabBarState extends State<ZCuppertinoTabBar> {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new Stack(
          alignment: Alignment.center,
          children: <Widget>[
            (widget.lockPrimeiraTab == false && widget.lockSegundaTab == false )?
            CupertinoSegmentedControl(
              groupValue: widget.tabInicial,
              selectedColor: widget.corTabSelecionada,
              padding: const EdgeInsets.all(0),
              borderColor: widget.corTabSelecionada,
              onValueChanged: widget.trocaDeTabs,
              children: <int, Widget>{
                0: new Container(
                  margin: const EdgeInsets.only(
                      left: 40, right: 40, top: 2, bottom: 2),
                  child: Text(
                    widget.primeiraTabNome,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                1: new Container(
                  margin: const EdgeInsets.only(
                      left: 40, right: 40, top: 2, bottom: 2),
                  child: Text(
                    widget.segundaTabNome,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                )
              },
            ):new Container(),
               _buildLockTab()
          ],
        )
    );
  }
  Widget _buildLockTab(){
    if(widget.lockSegundaTab == true)
    {
      return new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: (MediaQuery.of(context).size.width*widget.porcentagemLarguraTabLocks)/100,
                height: 30,
                decoration: new BoxDecoration(
                    color: widget.corTabSelecionada,
                    borderRadius: new BorderRadius.all(Radius.circular(6))
                ),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 5,
                      child: new Container(
                        margin: const EdgeInsets.only(top: 1,bottom: 1,left: 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0),
                            ),
                            color: widget.corTabSelecionada,),
                        child: new Center(child: new Text(widget.primeiraTabNome,style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                      ),
                    ),
                    new Expanded(
                      flex: 5,
                      child: new Container(
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(6.0),
                              bottomRight: Radius.circular(6.0),
                            ),
                            color: Colors.white),
                        child: new Center(child: new Text(widget.segundaTabNome,style: new TextStyle(color: Color(0xffE8E6E6),fontWeight: FontWeight.bold),),),


                      ),),
                  ],
                ),
              ),
            ],)
      );
    }
    else if(widget.lockPrimeiraTab == true)
    {
      return new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: (MediaQuery.of(context).size.width*widget.porcentagemLarguraTabLocks)/100,
                height: 30,
                decoration: new BoxDecoration(
                    color:widget.corTabSelecionada,
                    borderRadius: new BorderRadius.all(Radius.circular(6))
                ),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 5,
                      child: new Container(
                        margin: const EdgeInsets.only(top: 1,bottom: 1,left: 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0),
                            ),
                            color: Colors.white),
                        child: new Center(child: new Text(widget.primeiraTabNome,style: new TextStyle(color: Color(0xffE8E6E6),fontWeight: FontWeight.bold),),),
                      ),
                    ),
                    new Expanded(
                      flex: 5,
                      child: new Container(
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(6.0),
                              bottomRight: Radius.circular(6.0),
                            ),
                            color: widget.corTabSelecionada,),
                        child: new Center(child: new Text(widget.segundaTabNome,style: new TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                      ),),
                  ],
                ),
              ),
            ],)
      );
    }
    else{
      return new Container();
    }
  }

}

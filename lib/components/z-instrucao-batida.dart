import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class InformacaoBatida extends StatefulWidget {
 final Widget bottomChild;
  InformacaoBatida({Key key,
    this.bottomChild,
  }) : super(key: key);
  @override
  _InformacaoBatidaState createState() => _InformacaoBatidaState();
}

class _InformacaoBatidaState extends State<InformacaoBatida> {
  bool _visible2 = true;
  @override
  void initState() {

    Future.delayed(const Duration(milliseconds: 9250), () {
      setState(() {
        _visible2 = false;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueGrey,
      body: new Stack(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(top: 45),
                child: new Text("Para uma batida correta, \n tenha atenção às dicas abaixo:",
                  textAlign: TextAlign.center,
                  style: new TextStyle(color: Colors.white),),
              )
            ],),
          new FlareActor(
              "assets/anim.flr",
              alignment:Alignment.center,
              fit:BoxFit.scaleDown,
              animation:"condicoes_batida"),
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new AnimatedOpacity(
                    opacity: _visible2 ? 0 : 1,
                    duration: Duration(milliseconds: 500),
                    child: widget.bottomChild
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}

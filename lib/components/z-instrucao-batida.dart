import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class InformacaoBatida extends StatefulWidget {
  Widget bottomChild;
  InformacaoBatida({Key key,
    this.bottomChild,
  }) : super(key: key);
  @override
  _InformacaoBatidaState createState() => _InformacaoBatidaState();
}

class _InformacaoBatidaState extends State<InformacaoBatida> {
  bool _visible2 = true;

  bool _buttonEntendi = false;

  @override
  void initState() {

    Future.delayed(const Duration(milliseconds: 9250), () {
      setState(() {
        _visible2 = false;
        _buttonEntendi = true;
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
              fit:BoxFit.cover,
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
  Widget olas(){
    return new Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 5),
        child:  new ButtonTheme(
          minWidth: 145,
          child: new RaisedButton(
              color: Color(0xff2bbab4),
              child: new Text("ENTENDI",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
              onPressed: ()
              {
                if(_buttonEntendi == true)
                {
                  Navigator.pop(context);
                }
              },
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
          ),
        )
    );
  }
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}

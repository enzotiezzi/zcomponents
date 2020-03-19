import 'package:flutter/material.dart';

class ZCardAppBar extends StatefulWidget {
  final Key key;
  final ZCardAppBarType zCardAppBarType;
  ZCardAppBar({this.key, @required this.zCardAppBarType}): super(key: key);
  @override
  _ZCardAppBarState createState() => _ZCardAppBarState();
}

class _ZCardAppBarState extends State<ZCardAppBar> with TickerProviderStateMixin {

  AnimationController animationController;
  AnimationController animationControllerPendentes;
  AnimationController animationControllerAndamento;

  Animation animation;
  Animation animationAndamento;
  Animation animationPendentes;

  var carregouList = true;
  var carregouListPend = true;
  var carregouListAnd = true;

  var pendentes = true;
  var totalCh = true;
  var andamento = false;

  static Color backgroundColorTotalCham = const Color(0xff2bbab4);
  static Color primaryColorr = const Color(0xff2bbab4);


  Color corTextNumbTotal = Colors.white;
  Color corTextNumbPend = Colors.black;
  Color corTextNumbAnd = Colors.black;
  Color corTextWordTotal = Colors.white;
  Color textNumbPend = Colors.black;
  Color backgroundColorChPen = Colors.white;
  Color textWordPend = Color(0xff999999);
  Color backgroundColorChAnda = Colors.white;
  Color textNumbAnd = Colors.black;
  Color textWordAnda = Color(0xff999999);
  Color textNumbTotal = Colors.white;
  Color textWordTotal = Colors.white;


  @override
  void initState() {
    super.initState();

animationController    = new AnimationController(vsync: this);
animationControllerPendentes = new AnimationController(vsync: this);
animationControllerAndamento =  new AnimationController(vsync: this,duration: Duration(seconds: 5));
//animationController.forward();
  //animationControllerPendentes.forward();
     animationControllerAndamento.forward();

    animation =  IntTween(begin: 0, end: 10).animate(
        CurvedAnimation(
            parent: animationControllerAndamento,
            curve: Curves.easeOut));
    animationAndamento =IntTween(begin: 0, end: 10).animate(
        CurvedAnimation(
            parent: animationControllerAndamento,
            curve: Curves.easeOut));

    animationPendentes = IntTween(begin: 0, end: 10).animate(
        CurvedAnimation(
            parent: animationControllerAndamento,
            curve: Curves.easeOut));


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Zcard(),
    );
  }

  Widget Zcard() {
    switch (widget.zCardAppBarType) {
      case ZCardAppBarType.isZchamados:
        return  _cardTest();

        break;
      case ZCardAppBarType.isZexecutor:
        // TODO: Handle this case.
        break;
      case ZCardAppBarType.isZPonto:
        // TODO: Handle this case.
        break;
    }
  }
   Widget _cardTest() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(const Radius.circular(6)),
          ),
          child: new Row(
            children: <Widget>[
              _buildTotalChamadosDash(),
              _buildChamadosPendentesDash(),
              _buildChamadosAndamentoDash()
            ],
          ),
        )
      ],
    );
  }


  Widget _buildTotalChamadosDash() {
    return new InkWell(
      onTap: () {
        totalDeCham();
      },
      child: new AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: 90,
        height: 90,
        decoration: new BoxDecoration(
          color: backgroundColorTotalCham,
          borderRadius: BorderRadius.all(const Radius.circular(6)),
        ),
        margin: const EdgeInsets.only(left: 4, bottom: 4, top: 4),
        child: new Column(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                        animation: animationController,
                        builder: (BuildContext context, Widget child) {
                          return new Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: (carregouList != false)
                                  ? new Text(
                                      animation.value.toString(),
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: corTextNumbTotal),
                                    )
                                  : new Text(
                                      "0",
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: corTextNumbTotal),
                                    ));
                        }),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                        margin: const EdgeInsets.all(4),
                        width: 18,
                        height: 18,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: new Container(
                          margin: const EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ))
                  ],
                )
              ],
            ),
            new Container(
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
              child: new Text(
                "TOTAL DE\nCHAMADOS",
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 10, color: corTextWordTotal),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChamadosPendentesDash() {
    return new InkWell(
      onTap: () {
        chamPend();
      },
      child: new AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: 90,
        height: 90,
        decoration: new BoxDecoration(
          color: backgroundColorChPen,
          borderRadius: BorderRadius.all(const Radius.circular(6)),
        ),
        margin: const EdgeInsets.only(left: 4, bottom: 4, top: 4, right: 4),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                        animation: animationControllerPendentes,
                        builder: (BuildContext context, Widget child) {
                          return new Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: (carregouListPend != false)
                                  ? new Text(
                                      animationPendentes.value.toString(),
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: textNumbPend),
                                    )
                                  : new Text(
                                      "0",
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: textNumbPend),
                                    ));
                        }),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                        margin: const EdgeInsets.all(4),
                        width: 18,
                        height: 18,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: new Container(
                          margin: const EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Color(0xffFFB520),
                            shape: BoxShape.circle,
                          ),
                        ))
                  ],
                )
              ],
            ),
            new Container(
              padding:
                  const EdgeInsets.only(left: 6, right: 6, top: 8, bottom: 8),
              child: new Text(
                "CHAMADOS\nPENDENTES",
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 10, color: textWordPend),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildChamadosAndamentoDash() {
    return new InkWell(
      onTap: () {
        chamAtendimento();
      },
      child: new AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: 90,
        height: 90,
        decoration: new BoxDecoration(
          color: backgroundColorChAnda,
          borderRadius: BorderRadius.all(const Radius.circular(6)),
        ),
        margin: const EdgeInsets.only(bottom: 4, top: 4, right: 4),
        child: new Column(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                        animation: animationControllerAndamento,
                        builder: (BuildContext context, Widget child) {
                          return new Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: (carregouListAnd != false)
                                  ? new Text(
                                      animationAndamento.value.toString(),
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: textNumbAnd),
                                    )
                                  : new Text(
                                      "0",
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: textNumbAnd),
                                    ));
                        }),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                        margin: const EdgeInsets.all(4),
                        width: 18,
                        height: 18,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: new Container(
                          margin: const EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Color(0xff1AC15D),
                            shape: BoxShape.circle,
                          ),
                        ))
                  ],
                )
              ],
            ),
            new Container(
              padding:
                  const EdgeInsets.only(left: 6, right: 6, top: 8, bottom: 8),
              child: new Text(
                "CHAMADOS EM\nANDAMENTO",
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 10, color: textWordAnda),
              ),
            )
          ],
        ),
      ),
    );
  }

  void totalDeCham() {
    setState(() {
      backgroundColorTotalCham = primaryColorr;
      backgroundColorChPen = Colors.white;
      backgroundColorChAnda = Colors.white;
      textNumbTotal = Colors.white;
      textNumbPend = Colors.black;
      textNumbAnd = Colors.black;
      textWordTotal = Colors.white;
      textWordPend = Color(0xff999999);
      textWordAnda = Color(0xff999999);
      pendentes = false;
      totalCh = true;
      andamento = false;
    });
  }

  void chamPend() {
    setState(() {
      backgroundColorTotalCham = Colors.white;
      backgroundColorChPen = primaryColorr;
      backgroundColorChAnda = Colors.white;
      textNumbTotal = Colors.black;
      textNumbPend = Colors.white;
      textNumbAnd = Colors.black;
      textWordTotal = Color(0xff999999);
      textWordPend = Colors.white;
      textWordAnda = Color(0xff999999);
      pendentes = true;
      totalCh = false;
      andamento = false;
    });
  }

  void chamAtendimento() {
    setState(() {
      backgroundColorTotalCham = Colors.white;
      backgroundColorChPen = Colors.white;
      backgroundColorChAnda = primaryColorr;
      textNumbTotal = Colors.black;
      textNumbPend = Colors.black;
      textNumbAnd = Colors.white;
      textWordTotal = Color(0xff999999);
      textWordPend = Color(0xff999999);
      textWordAnda = Colors.white;
      pendentes = false;
      totalCh = false;
      andamento = true;
    });
  }
}

enum ZCardAppBarType { isZchamados, isZexecutor, isZPonto }

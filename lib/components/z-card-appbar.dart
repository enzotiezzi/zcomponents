import 'package:flutter/material.dart';

class ZCardAppBar extends StatefulWidget {
  final Key? key;
  final ZCardAppBarType? zCardAppBarType;

  Color? backgroundColorTotalCham = const Color(0xff2bbab4);
  Color? primaryColor = const Color(0xff2bbab4);
  Color? backgroundColorChPen = Colors.white;
  Color? backgroundColorChAnda = Colors.white;
  Color? textNumbTotal = Colors.white;
  Color? textNumbPend = Colors.black;
  Color? textNumbAnd = Colors.black;
  Color? textWordTotal = Colors.white;
  Color? textWordPend = Color(0xff999999);
  Color? textWordAnda = Color(0xff999999);
  Color? corTextNumbTotal = Colors.white;
  Color? corTextNumbPend = Colors.black;
  Color? corTextNumbAnd = Colors.black;
  Color? corTextWordTotal = Colors.white;

  late AnimationController? animationControllerTotal;
  late AnimationController? animationControllerPendentes;
  late AnimationController? animationControllerAndamento;

  late Animation? animationTotal;
  late Animation? animationAndamento;
  late Animation? animationPendentes;

  int? durationAnimation = 5;

  bool? carregouList = true;
  bool? carregouListPend = true;
  bool? carregouListAnd = true;

  bool? pendentes = true;
  bool? totalCh = true;
  bool? andamento = false;


  ZCardAppBar(
      {this.key,
      @required this.zCardAppBarType,
      this.backgroundColorTotalCham,
      this.primaryColor,
      this.andamento,
      this.animationAndamento,
      this.animationControllerAndamento,
      this.animationControllerPendentes,
      this.animationControllerTotal,
      this.animationPendentes,
        this.animationTotal,
        this.backgroundColorChAnda,
        this.backgroundColorChPen,
        this.carregouList,
        this.carregouListAnd,
        this.carregouListPend,
        this.corTextNumbAnd,
        this.corTextNumbPend,
        this.corTextNumbTotal,
        this.corTextWordTotal,
        this.durationAnimation,
        this.pendentes,
        this.textNumbAnd,
        this.textNumbPend,
        this.textNumbTotal,
        this.textWordAnda,
        this.textWordPend,
        this.textWordTotal,
        this.totalCh,
      })
      : super(key: key);

  @override
  _ZCardAppBarState createState() => _ZCardAppBarState();
}

class _ZCardAppBarState extends State<ZCardAppBar>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    widget.animationControllerTotal = new AnimationController(vsync: this);
    widget.animationControllerPendentes = new AnimationController(vsync: this);
    widget.animationControllerAndamento = new AnimationController(
        vsync: this, duration: Duration(seconds: 5));

    widget.animationTotal = IntTween(begin: 0, end: 10).animate(CurvedAnimation(
        parent: widget.animationControllerAndamento!, curve: Curves.easeOut));

    widget.animationAndamento = IntTween(begin: 0, end: 10).animate(
        CurvedAnimation(
            parent: widget.animationControllerAndamento!,
            curve: Curves.easeOut));

    widget.animationPendentes = IntTween(begin: 0, end: 10).animate(
        CurvedAnimation(
            parent: widget.animationControllerAndamento!,
            curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Zcard(),
    );
  }

  Widget? Zcard() {
    switch (widget.zCardAppBarType) {
      case ZCardAppBarType.isZchamados:
        return _cardTest();

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
          color: widget.backgroundColorTotalCham,
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
                        animation: widget.animationControllerTotal!,
                        builder: (BuildContext? context, Widget? child) {
                          return new Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: (widget.carregouList != false)
                                  ? new Text(
                                      widget.animationTotal!.value.toString(),
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: widget.corTextNumbTotal),
                                    )
                                  : new Text(
                                      "0",
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: widget.corTextNumbTotal),
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
                style:
                    new TextStyle(fontSize: 10, color: widget.corTextWordTotal),
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
          color: widget.backgroundColorChPen,
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
                        animation: widget.animationControllerPendentes!,
                        builder: (BuildContext? context, Widget? child) {
                          return new Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: (widget.carregouListPend != false)
                                  ? new Text(
                                      widget.animationPendentes!.value
                                          .toString(),
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: widget.textNumbPend),
                                    )
                                  : new Text(
                                      "0",
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: widget.textNumbPend),
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
                style: new TextStyle(fontSize: 10, color: widget.textWordPend),
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
          color: widget.backgroundColorChAnda,
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
                        animation: widget.animationControllerAndamento!,
                        builder: (BuildContext context, Widget? child) {
                          return new Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: (widget.carregouListAnd != false)
                                  ? new Text(
                                      widget.animationAndamento!.value
                                          .toString(),
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: widget.textNumbAnd),
                                    )
                                  : new Text(
                                      "0",
                                      style: new TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: widget.textNumbAnd),
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
                style: new TextStyle(fontSize: 10, color: widget.textWordAnda),
              ),
            )
          ],
        ),
      ),
    );
  }

  void totalDeCham() {
    setState(() {
      widget.backgroundColorTotalCham = widget.primaryColor;
      widget.backgroundColorChPen = Colors.white;
      widget.backgroundColorChAnda = Colors.white;
      widget.textNumbTotal = Colors.white;
      widget.textNumbPend = Colors.black;
      widget.textNumbAnd = Colors.black;
      widget.textWordTotal = Colors.white;
      widget.textWordPend = Color(0xff999999);
      widget.textWordAnda = Color(0xff999999);
      widget.pendentes = false;
      widget.totalCh = true;
      widget.andamento = false;
    });
  }

  void chamPend() {
    setState(() {
      widget.backgroundColorTotalCham = Colors.white;
      widget.backgroundColorChPen = widget.primaryColor;
      widget.backgroundColorChAnda = Colors.white;
      widget.textNumbTotal = Colors.black;
      widget.textNumbPend = Colors.white;
      widget.textNumbAnd = Colors.black;
      widget.textWordTotal = Color(0xff999999);
      widget.textWordPend = Colors.white;
      widget.textWordAnda = Color(0xff999999);
      widget.pendentes = true;
      widget.totalCh = false;
      widget.andamento = false;
    });
  }

  void chamAtendimento() {
    setState(() {
      widget.backgroundColorTotalCham = Colors.white;
      widget.backgroundColorChPen = Colors.white;
      widget.backgroundColorChAnda = widget.primaryColor;
      widget.textNumbTotal = Colors.black;
      widget.textNumbPend = Colors.black;
      widget.textNumbAnd = Colors.white;
      widget.textWordTotal = Color(0xff999999);
      widget.textWordPend = Color(0xff999999);
      widget.textWordAnda = Colors.white;
      widget.pendentes = false;
      widget.totalCh = false;
      widget.andamento = true;
    });
  }
}

enum ZCardAppBarType { isZchamados, isZexecutor, isZPonto }

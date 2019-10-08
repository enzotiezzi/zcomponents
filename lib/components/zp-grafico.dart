import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class ZPGrafico extends StatefulWidget {

  final bool initiallyExpanded;

  final String titulo;

  final GestureTapCallback onTapItem1;
  final GestureTapCallback onTapItem2;
  final GestureTapCallback onTapItem3;

  final String tituloCenterCircle;

  final double valueItem1;
  final double valueItem2;
  final double valueItem3;

  final String tituloItem1;
  final String tituloItem2;
  final String tituloItem3;


  ZPGrafico({Key key,
    this.initiallyExpanded = false,
    this.onTapItem1,
    this.onTapItem2,
    this.onTapItem3,
    this.titulo = "",
    this.tituloCenterCircle = "",
    this.valueItem1 = 0.0,
    this.valueItem2 = 0.0,
    this.valueItem3 = 0.0,
    this.tituloItem1 = "",
    this.tituloItem2 = "",
    this.tituloItem3 = "",
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZPGraficoState();

}

class _ZPGraficoState extends State<ZPGrafico> with TickerProviderStateMixin{
  Map<String, String> _meses = {
    "1": "01",
    "2": "02",
    "3": "03",
    "4": "04",
    "5": "05",
    "6": "06",
    "7": "07",
    "8": "08",
    "9": "09",
    "10": "10",
    "11": "11",
    "12": "12",
  };
  Map<String, String> _dias = {
    "1": "01",
    "2": "02",
    "3": "03",
    "4": "04",
    "5": "05",
    "6": "06",
    "7": "07",
    "8": "08",
    "9": "09",
    "10": "10",
    "11": "11",
    "12": "12",
    "13": "13",
    "14": "14",
    "15": "15",
    "16": "16",
    "17": "17",
    "18": "18",
    "19": "19",
    "20": "20",
    "21": "21",
    "22": "22",
    "23": "23",
    "24": "24",
    "25": "25",
    "26": "26",
    "27": "27",
    "28": "28",
    "29": "29",
    "30": "30",
    "31": "31",
  };
  var _dia = new DateFormat.d().format(new DateTime.now());
  var _mes = new DateFormat.M().format(new DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  void dismiss() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      new Container(
        decoration: BoxDecoration(
        border: Border.all(
        color: Colors.grey.withOpacity(0.1), width: 2.0),
    color: const Color(0xffDBDBDB).withOpacity(0.6),
    borderRadius: BorderRadius.all(Radius.circular(7.0))),
    margin: EdgeInsets.only(left: 7.0, right: 7.0),
    child:new ConfigurableExpansionTile(
      key: widget.key,
      initiallyExpanded: widget.initiallyExpanded,
      onExpansionChanged: (bool) {
        setState(() {
          //_secondExpansionVisible = !bool;
        });
      },
      animatedWidgetFollowingHeader:
      new Icon(Icons.keyboard_arrow_down),
      header: new Expanded(
        child: new Container(
          padding: EdgeInsets.all(3.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Container(
                    child: new Text(widget.titulo),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 5.0),
                    padding: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(7.0))),
                    child: new Text(
                      "${_dias[_dia]}/${_meses[_mes]}",
                      style: TextStyle(
                          color: const Color(0xff707070),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(
                        right: 3.0, left: 3.0),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(5.0)),
                        color: Colors.red),
                    padding: EdgeInsets.all(5.0),
                    child: new Text(
                      "${widget.valueItem1}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0),
                    ),
                  ),
                  new Container(
                    margin:
                    EdgeInsets.only(right: 3.0),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(5.0)),
                        color: Colors.orange),
                    padding: EdgeInsets.all(5.0),
                    child: new Text(
                        "${widget.valueItem2}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0)),
                  ),
                  new Container(
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(5.0)),
                        color: Colors.green),
                    padding: EdgeInsets.all(5.0),
                    child: new Text(
                        "${widget.valueItem3}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      children: <Widget>[_secondExpansion()],
    ));
  }
  Widget _secondExpansion() {
    return new Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7.0),
              bottomRight: Radius.circular(7.0))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Container(
            child: AnimatedCircularChart(
                holeLabel: widget.tituloCenterCircle,
                labelStyle: TextStyle(fontSize: 10.0, color: Colors.black),
                duration: Duration(milliseconds: 500),
                size: Size.fromRadius(60.0),
                initialChartData: <CircularStackEntry>[
                  new CircularStackEntry(
                    <CircularSegmentEntry>[
                      new CircularSegmentEntry(
                        widget.valueItem1,
                        Colors.red,
                        rankKey: 'remaining',
                      ),
                      new CircularSegmentEntry(
                        widget.valueItem2,
                        Colors.orange,
                        rankKey: 'remaining',
                      ),
                      new CircularSegmentEntry(
                        widget.valueItem3,
                        Colors.green,
                        rankKey: 'complete',
                      ),
                    ],
                    rankKey: 'progress',
                  ),
                ]),
          ),
          new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new GestureDetector(
                  onTap:  widget.onTapItem1,
                  child: new Container(
                      width: (MediaQuery.of(context).size.width / 2.1),
                      color: const Color(0xffF7F7F7),
                      margin: EdgeInsets.only(bottom: 3.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                ),
                                height:
                                (MediaQuery.of(context).size.height / 16),
                                width: 5.0,
                              ),
                              new Container(
                                padding: EdgeInsets.only(right: 10.0),
                                child: new Text(
                                    "${widget.valueItem1}",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              new Text(
                                widget.tituloItem1,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          new Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                          ),
                        ],
                      )),
                ),
                new GestureDetector(
                  onTap:  widget.onTapItem2,
                  child: new Container(
                      width: (MediaQuery.of(context).size.width / 2.1),
                      color: const Color(0xffF7F7F7),
                      margin: EdgeInsets.only(bottom: 3.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                ),
                                height:
                                (MediaQuery.of(context).size.height / 16),
                                width: 5.0,
                              ),
                              new Container(
                                padding: EdgeInsets.only(right: 10.0),
                                child: new Text(
                                    "${widget.valueItem2}",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              new Text(
                                widget.tituloItem2,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          new Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                          ),
                        ],
                      )),
                ),
                new GestureDetector(
                  onTap:  widget.onTapItem3,
                  child: new Container(
                      width: (MediaQuery.of(context).size.width / 2.1),
                      color: const Color(0xffF7F7F7),
                      margin: EdgeInsets.only(bottom: 3.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                ),
                                height:
                                (MediaQuery.of(context).size.height / 16),
                                width: 5.0,
                              ),
                              new Container(
                                padding: EdgeInsets.only(right: 10.0),
                                child: new Text(
                                    "${widget.valueItem3}",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              new Text(
                                widget.tituloItem3,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          new Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

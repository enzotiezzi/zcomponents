import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ZProgressDialog extends StatefulWidget {
  String message;
  bool barrierDismissible;
  double progressBarValue;
  bool complete;
  bool sucess;
  int animationDuration;
  Key key;

  ZProgressDialog(
      {this.message: "",
      this.barrierDismissible: true,
      this.progressBarValue: 0.0,
      this.key,
      this.complete: false,
      this.sucess: true,
      this.animationDuration: 250})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ZProgressDialogState();
}

class ZProgressDialogState extends State<ZProgressDialog>
    with TickerProviderStateMixin {
  double iconSize = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.barrierDismissible == true) {
          Navigator.pop(context);
        }
      },
      child: new Container(
        color: Colors.transparent,
        child: Center(
            child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {},
                  child: new Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      padding: const EdgeInsets.all(0),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(6))),
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: new Column(
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: new LinearPercentIndicator(
                                        animation: true,
                                        lineHeight: 12.0,
                                        padding: const EdgeInsets.only(
                                            left: 6, right: 6),
                                        animateFromLastPercent: true,
                                        animationDuration:
                                            widget.animationDuration,
                                        backgroundColor: Colors.white,
                                        percent:
                                            (widget.progressBarValue > 1.0 ||
                                                    widget.progressBarValue < 0)
                                                ? 1.0
                                                : widget.progressBarValue,
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: (widget.sucess == true &&
                                                widget.progressBarValue < 1.0)
                                            ? Color(0xff2bbab4)
                                            : (widget.sucess == true)
                                                ? Color(0xff1AC15D)
                                                : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Container(
                                      width: MediaQuery.of(context).size.width * 0.70,
                                        margin: const EdgeInsets.only(
                                            top: 16, bottom: 16),
                                        child: new Text(
                                          widget.message,
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    (widget.progressBarValue == 1.0)
                                        ? new Container()
                                        : new SpinKitThreeBounce(
                                            color: Colors.black,
                                            size: 20.0,
                                          )
                                  ],
                                ),
                                new Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: (widget.sucess == true)
                                      ? new AnimatedSize(
                                          vsync: this,
                                          duration:
                                              new Duration(milliseconds: 250),
                                          curve: Curves.easeIn,
                                          child: new Icon(
                                            Icons.check_circle,
                                            color: Color(0xff1AC15D),
                                            size:
                                                (widget.progressBarValue == 1.0)
                                                    ? 24
                                                    : 0,
                                          ),
                                        )
                                      : new AnimatedSize(
                                          vsync: this,
                                          duration:
                                              new Duration(milliseconds: 250),
                                          curve: Curves.easeIn,
                                          child: new Icon(
                                            Icons.clear,
                                            color: Colors.red,
                                            size:
                                                (widget.progressBarValue == 1.0)
                                                    ? 24
                                                    : 0,
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ))),
      ),
    );
  }

  void refresh(double newValueProgress, String newValueMessage, {bool success}) {
    if (success == null) {
      success = true;
    }
    setState(() {
      widget.progressBarValue = newValueProgress;
      widget.message = newValueMessage;
      widget.sucess = success;
    });
  }
}

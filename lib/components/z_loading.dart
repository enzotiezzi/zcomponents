import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/config/z-platform.dart';

class ZLoading extends StatelessWidget {
  Widget _zLoading;

  final BuildContext context;
  final Key key;
  final double value;
  final Color backgroundColor;
  final Animation<Color> valueColor;
  final double strokeWidth;
  final String semanticsLabel;
  final String semanticsValue;
  final bool animating;
  final double radius;
  final ZPlatform zPlatform;
  final Color color;


  ZLoading({
    this.context,
    this.key,
    this.value,
    this.backgroundColor,
    this.valueColor,
    this.strokeWidth = 4.0,
    this.semanticsLabel,
    this.semanticsValue,
    this.animating = true,
    this.radius = 15.0,
    this.zPlatform = ZPlatform.isPlatform,
    this.color: const Color(0xff2BB9B4),

  }) : super(key: key) {
    _zLoading = new Container(
      width: 60,
      height: 60,
      child: new Card(
          elevation: 6,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          color: this.color,
          child:
          new Stack(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.all(5.0),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                child: new Material(
                    color: this.color,
                    borderRadius: new BorderRadius.circular(25.0),
                    child: new SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        key: this.key,
                        value: this.value,
                        backgroundColor: this.backgroundColor,
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.white),
                        strokeWidth: this.strokeWidth,
                        semanticsLabel: this.semanticsLabel,
                        semanticsValue: this.semanticsValue,
                      ),
                    )
                ),
              ),
              new Container(
                child: new Center(
                  child: new Container(
                    height: 19,
                    width: 19,
                    child: Image(image: AssetImage('assets/z.png'),
                      fit: BoxFit.scaleDown,),
                  ),
                ),
              )

            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  /*  Timer _timer;
    timeOutRequest("15", _timer);*/
    return _zLoading;
  }


}
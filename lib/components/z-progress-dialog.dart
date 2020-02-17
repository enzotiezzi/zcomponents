import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ZProgressDialog extends StatelessWidget {
  Widget _zProgressDialog;
  final BuildContext context;
  final Key key;
  final EdgeInsetsGeometry contentPadding;
  final Widget child;
  final Color colorLine;
  final Color colorBackgroundLinear;
  final Color colorLoadLinear;

  ZProgressDialog({
    @required this.context,
    this.child,
    this.key,
    this.colorLine = const Color(0xffC7C7CC),
    this.colorBackgroundLinear = const Color(0xffCECECE),
    this.colorLoadLinear = const Color(0xff2BBAB4),
    this.contentPadding = const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
  })  : assert(contentPadding != null),
        super(key: key) {

    _zProgressDialog = AlertDialog(
      backgroundColor: Colors.white,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0,
      key: this.key,
      title: new Container(
        width: double.infinity,
        height: 5,
        decoration: new BoxDecoration(
            color: colorLine,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(5.0),
                topRight: const Radius.circular(5.0))),
      ),
      titlePadding: EdgeInsets.all(0.0),
      contentPadding: this.contentPadding,
      content: new Container(
        color: Colors.transparent,
        child: Center(
            child: Material(
                color: Colors.transparent,
                child:
                GestureDetector(
                  onTap: (){
                  },
                  child: new Container(
                      height: 106,
                      width: 400,
                      padding: const EdgeInsets.all(0),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.all(Radius.circular(6))
                      ),
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Container(
                            width: MediaQuery.of(context).size.width*0.80,
                            child: new Column(
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: new LinearPercentIndicator(
                                        animation: true,
                                        lineHeight: 12.0,
                                        padding: const EdgeInsets.only(left:6,right: 6),
                                        backgroundColor: Colors.white,
                                        animateFromLastPercent: true,
                                        animationDuration: 250,
                                        percent: 0.3,
                                        linearStrokeCap: LinearStrokeCap.roundAll,
                                        progressColor: Color(0xff2bbab4),
                                      ),)
                                  ],
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Container(
                                        margin: const EdgeInsets.only(top: 16,bottom: 16),
                                        child:new Text("Custom Text!!",style: new TextStyle(fontWeight: FontWeight.bold),)
                                    )
                                  ],
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[

                                   /* SpinKitThreeBounce(
                                      color: Colors.black,
                                      size: 20.0,
                                    )*/
                                   /* (_view.escondeCarregamento == false)?
                                    SpinKitThreeBounce(
                                      color: Colors.black,
                                      size: 20.0,
                                    ):new Container()*/
                                  ],
                                ),
                               /* new Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child:
                                  (_view.sucesso == true)?
                                  new AnimatedSize(
                                    vsync: this,
                                    duration: new Duration(milliseconds: 250),
                                    curve: Curves.easeIn,
                                    child: new Icon(Icons.check_circle,color: Color(0xff1AC15D),size: _view.sizeIcon,),
                                  ): new AnimatedSize(
                                    vsync: this,
                                    duration: new Duration(milliseconds: 250),
                                    curve: Curves.easeIn,
                                    child: new Icon(Icons.clear,color: Colors.red,size: _view.sizeIcon,),
                                  ),
                                )*/
                              ],),
                          ),
                        ],
                      )
                  ),
                )
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _zProgressDialog;
  }
}

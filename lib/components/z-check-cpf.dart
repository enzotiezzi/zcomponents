import 'package:flutter/material.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/config/z-dialog.dart';

class ZCheckCPF extends StatefulWidget {
  _ZCheckCPFState state;

  ZCheckCPF({Key key,
  }) : super(key: key);

  @override
  _ZCheckCPFState createState() {
    state = new _ZCheckCPFState();

    return state;
  }
}

class _ZCheckCPFState extends State<ZCheckCPF> with TickerProviderStateMixin{

  bool _temcpf = false;


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
    return new Container(
      child: new GestureDetector(
        onTap: () {
          setState(() {
            _temcpf = !_temcpf;
          });
        },
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: new Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 1,
                    child: new Container(
                      padding: EdgeInsets.only(left: 2,right: 10,top: 2,bottom: 2),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                              decoration: BoxDecoration(
                                  color: (_temcpf == false)
                                      ? Colors.white
                                      : Color(0xff2BB9B4),
                                  border:
                                  Border.all(color: Colors.grey.withOpacity(0.6)),
                                  shape: BoxShape.circle),
                              height: 25.0,
                              width: 25.0,
                              child: new AnimatedSize(
                                duration: Duration(milliseconds: 5000),
                                curve: Curves.fastOutSlowIn,
                                vsync: this,
                                child: new Icon(Icons.brightness_1,
                                    color: Colors.white,
                                    size: (_temcpf == true) ? 20.0 : 0.0),
                              )),
                          new Container(
                            margin: EdgeInsets.only(left: 4.0),
                            child: new Text(
                              "NÃO POSSUO CPF",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    )
                )
            ),
          ],
        )
      ),
    );
  }

  void showAlertDialogNew(String title, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ZAlertDialog(
          zDialog: ZDialog.erro,
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.all(8),
                    child: new Text(
                      title,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 16),
                    child: new Text(
                      message,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: const Color(0xff707070), fontSize: 13),
                    ),
                  )
                ],
              ),
              new Divider(
                color: const Color(0xffdbdbdb),
              ),
              new Container(
                child: new InkWell(
                  borderRadius:
                  new BorderRadius.all(const Radius.circular(20.0)),
                  splashColor: const Color(0xffe6e6e6),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: new Container(
                    padding: const EdgeInsets.all(12),
                    child: new Text(
                      "ENTENDI",
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 8),
              )
            ],
          ),
        ));
  }
}

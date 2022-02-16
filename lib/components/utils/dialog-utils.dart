import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-alert-dialog.dart';
import 'package:z_components/components/z-progress-dialog.dart';
import 'package:z_components/components/z_loading.dart';
import 'package:z_components/config/z-dialog.dart';
import 'package:z_components/styles/main-style.dart';

class DialogUtils {
  BuildContext _context;

  DialogUtils(BuildContext context) {
    _context = context;
  }

  Future showAlertDialogErro(String title, String message,
      {String errorMessage}) async {
    return showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) => ZAlertDialog(
              zDialog: ZDialog.erro,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(20),
                        child: new Text(title,
                            style: MainStyle.get(context).styleTittleDialog),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Column(
                          children: <Widget>[
                            new Text(message,
                                style: new TextStyle(
                                    fontSize: MainStyle.get(context)
                                        .fontSizeEntradaSaida),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      )
                    ],
                  ),
                  new Divider(
                    color: const Color(0xffdbdbdb),
                  ),
                  new Container(
                    child: new InkWell(
                        splashColor: const Color(0xffe6e6e6),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              padding: EdgeInsets.all(12),
                              child: new Text(
                                "FECHAR",
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: MainStyle.get(context)
                                        .fontSizeLeadinCancelar),
                              ),
                            ),
                          ],
                        )),
                    margin: const EdgeInsets.only(bottom: 8),
                  )
                ],
              ),
            ));
  }

  Future showAlertDialogNewAviso(String title, String message) async {
    return showDialog(
        context: _context,
        barrierDismissible: true,
        builder: (BuildContext context) => ZAlertDialog(
              zDialog: ZDialog.alert,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(20),
                        child: new Text(
                          title,
                          style: MainStyle.get(context).styleTittleDialog,
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Column(
                          children: <Widget>[
                            new Text(message,
                                style: new TextStyle(
                                    fontSize: MainStyle.get(context)
                                        .fontSizeEntradaSaida),
                                textAlign: TextAlign.center),
                          ],
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
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MainStyle.get(context)
                                  .fontSizeLeadinCancelar),
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                  )
                ],
              ),
            ));
  }

  Future showAlertDialogAcao(String title, String message,
      {Function onCameraPressed = null,
      Function onGaleryPressed = null}) async {
    return showDialog(
        context: _context,
        barrierDismissible: true,
        builder: (BuildContext context) => ZAlertDialog(
              zDialog: ZDialog.normal,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(20),
                        child: new Text(title,
                            style: MainStyle.get(context).styleTittleDialog),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Column(
                          children: <Widget>[
                            new Text(message,
                                style: new TextStyle(
                                    fontSize: MainStyle.get(context)
                                        .fontSizeEntradaSaida),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      )
                    ],
                  ),
                  new Divider(
                    color: const Color(0xffdbdbdb),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                        child: new InkWell(
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(20.0)),
                          splashColor: const Color(0xffe6e6e6),
                          onTap: () {
                            Navigator.pop(_context);
                            if (onGaleryPressed != null) onGaleryPressed();
                          },
                          child: new Container(
                            padding: const EdgeInsets.all(12),
                            child: new Text(
                              "GALERIA",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MainStyle.get(context)
                                      .fontSizeLeadinCancelar),
                            ),
                          ),
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                      ),
                      new Container(
                        child: new InkWell(
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(20.0)),
                          splashColor: const Color(0xffe6e6e6),
                          onTap: () {
                            Navigator.pop(_context);
                            if (onCameraPressed != null) onCameraPressed();
                          },
                          child: new Container(
                            padding: const EdgeInsets.all(12),
                            child: new Text(
                              "CÂMERA",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MainStyle.get(context)
                                      .fontSizeLeadinCancelar),
                            ),
                          ),
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                      )
                    ],
                  )
                ],
              ),
            ));
  }

  Future showAlertDialogErroAcao(String title, String message,
      {Function onLoginPressed = null}) async {
    return showDialog(
        context: _context,
        barrierDismissible: true,
        builder: (BuildContext context) => ZAlertDialog(
              zDialog: ZDialog.erro,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(20),
                        child: new Text(title,
                            style: MainStyle.get(context).styleTittleDialog),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Column(
                          children: <Widget>[
                            new Text(message,
                                style: new TextStyle(
                                    fontSize: MainStyle.get(context)
                                        .fontSizeEntradaSaida),
                                textAlign: TextAlign.center),
                          ],
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
                        Navigator.pop(_context);
                        if (onLoginPressed != null) onLoginPressed();
                      },
                      child: new Container(
                        padding: const EdgeInsets.all(12),
                        child: new Text(
                          "Login",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MainStyle.get(context)
                                  .fontSizeLeadinCancelar),
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                  )
                ],
              ),
            ));
  }

  void showProgressDialog() {
    Future.delayed(new Duration(milliseconds: 0)).then((_) {
      showDialog(
          context: _context,
          barrierDismissible: false,
          builder: (BuildContext context) => new AlertDialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                content: new Container(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[new ZLoading()],
                  ),
                ),
              ));
    });
  }

  void closeApp(String title, String message, String buttonTextOk,
      [String buttonTextCancel = ""]) {
    Future.delayed(new Duration(milliseconds: 0)).then((_) {
      showDialog(
          context: _context,
          builder: (BuildContext context) => new CupertinoAlertDialog(
                  title: new Text(title),
                  content: new Text(message),
                  actions: <Widget>[
                    new CupertinoDialogAction(
                        child: new Text(buttonTextCancel),
                        onPressed: () {
                          dismiss();
                        }),
                    new CupertinoDialogAction(
                      child: new Text(buttonTextOk),
                      onPressed: () => exit(0),
                    ),
                  ]));
    });
  }

  Future showAlertDialog(String title, String message, String buttonTextOk,
      {String buttonTextCancel = "", Function onOkPressed = null}) async {
    var buttons = new List<Widget>();

    buttons.add(new CupertinoDialogAction(
        child: new Text(
          buttonTextOk,
          style: const TextStyle(color: Colors.blue),
        ),
        onPressed: () {
          Navigator.pop(_context);
          if (onOkPressed != null) onOkPressed();
        }));

    if (buttonTextCancel.length != 0)
      buttons.add(new CupertinoDialogAction(
          child: new Text(buttonTextCancel),
          onPressed: () {
            dismiss();
          }));

    return showDialog(
        context: _context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
            title: new Text(title),
            content: new Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: new Text(message),
            ),
            actions: buttons));
  }

  Future showSuccessDialog(String message) async {
    return showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) => ZAlertDialog(
              zDialog: ZDialog.sucess,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(12),
                        child: new Text(
                          message,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                  new Divider(
                    color: const Color(0xffdbdbdb),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
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
                  )
                ],
              ),
            ));
  }

  Future showZProgressDialog(String messagem, double barValue, var key) {
    return showDialog(
        context: _context,
        builder: (BuildContext context) => new ZProgressDialog(
              message: messagem,
              barrierDismissible: false,
              progressBarValue: barValue,
              key: key,
            ));
  }

  void dismiss() {
    Navigator.pop(_context);
  }
}

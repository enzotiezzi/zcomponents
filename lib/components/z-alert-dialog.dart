import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:z_components/config/z-dialog.dart';

class ZAlertDialog extends StatelessWidget {
  Widget _zAlertDialog;

  final Key key;
  final EdgeInsetsGeometry contentPadding;
  final ZDialog zDialog;
  final Widget child;
  final Color colorLine;
  final Color colorBackgroundLinear;
  final Color colorLoadLinear;

  ZAlertDialog({
    this.child,
    this.key,
    this.colorLine = const Color(0xffC7C7CC),
    this.colorBackgroundLinear = const Color(0xffCECECE),
    this.colorLoadLinear = const Color(0xff2BBAB4),
    this.contentPadding = const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    this.zDialog = ZDialog.zDialog,
  })  : assert(contentPadding != null),
        super(key: key) {
    switch (zDialog) {
      case ZDialog.normal:
        _zAlertDialog = AlertDialog(
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
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[(child == null) ? new Container() : child],
          ),
        );
        break;
      case ZDialog.alert:
        _zAlertDialog = AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0,
          key: this.key,
          title: new Container(
            width: double.infinity,
            height: 5,
            decoration: new BoxDecoration(
                color: const Color(0xffFFB520),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(5.0),
                    topRight: const Radius.circular(5.0))),
          ),
          titlePadding: EdgeInsets.all(0.0),
          contentPadding: this.contentPadding,
          content: new Container(
            margin: const EdgeInsets.only(top: 12),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(
                      Icons.warning,
                      color: Color(0xffFFB520),
                    )
                  ],
                ),
                (child == null) ? new Container() : child
              ],
            ),
          ),
        );
        break;
      case ZDialog.erro:
        _zAlertDialog = AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0,
          key: this.key,
          title: new Container(
            width: double.infinity,
            height: 5,
            decoration: new BoxDecoration(
                color: const Color(0xffE53629),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(5.0),
                    topRight: const Radius.circular(5.0))),
          ),
          titlePadding: EdgeInsets.all(0.0),
          contentPadding: this.contentPadding,
          content: new Container(
            margin: const EdgeInsets.only(top: 12),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(
                      Icons.error,
                      color: Color(0xffE53629),
                    )
                  ],
                ),
                (child == null) ? new Container() : child
              ],
            ),
          ),
        );
        break;
      case ZDialog.sucess:
        _zAlertDialog = AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0,
          key: this.key,
          title: new Container(
            width: double.infinity,
            height: 5,
            decoration: new BoxDecoration(
                color: const Color(0xff1AC15D),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(5.0),
                    topRight: const Radius.circular(5.0))),
          ),
          titlePadding: EdgeInsets.all(0.0),
          contentPadding: this.contentPadding,
          content: new Container(
            margin: const EdgeInsets.only(top: 12),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(
                      Icons.check_circle,
                      color: Color(0xff1AC15D),
                    )
                  ],
                ),
                (child == null) ? new Container() : child
              ],
            ),
          ),
        );
        break;
      case ZDialog.linearLoad:
        _zAlertDialog = AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0,
          key: this.key,
          title: new LinearProgressIndicator(
            backgroundColor: colorBackgroundLinear,
            valueColor: new AlwaysStoppedAnimation<Color>(colorLoadLinear),
          ),
          titlePadding: EdgeInsets.all(0.0),
          contentPadding: this.contentPadding,
          content: new Container(
            margin: const EdgeInsets.only(top: 12),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[(child == null) ? new Container() : child],
            ),
          ),
        );
        break;
      case ZDialog.zDialog:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _zAlertDialog;
  }
}

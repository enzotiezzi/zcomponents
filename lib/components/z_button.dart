import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/config/z-button-type.dart';

class ZButton extends StatelessWidget {
  Widget? _zButton;
  final Key? key;
  final VoidCallback? onPressed;
  final String? text;
  final Icon? iconLeft;
  final Icon? iconRight;
  final ZButtonType? zButtonType;
  final Color? color;
  final Color? textColor;

  ZButton({
    this.key,
    @required this.onPressed,
    this.text,
    this.iconLeft,
    this.iconRight,
    this.zButtonType = ZButtonType.isContained,
    this.color: const Color(0xff2BBAB4),
    this.textColor: const Color(0xff2BBAB4)
  }) : super(key: key) {
    switch (zButtonType) {
      case ZButtonType.isContained:
        _zButton = new ElevatedButton(
          onPressed: (){
            if(this.onPressed != null){
              this.onPressed!();
            }
          },
          child: new Container(
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (this.iconLeft != null)
                    ? new Container(child: this.iconLeft)
                    : new Container(),
                new Container(
                  padding: const EdgeInsets.only(right: 6, left: 6),
                  child: new Text(
                    this.text != null ? this.text! : "",
                    style: TextStyle(color: textColor, fontSize: 20.0),
                  ),
                ),
                (this.iconRight != null)
                    ? new Container(
                        margin: const EdgeInsets.only(), child: this.iconRight)
                    : new Container(),
              ],
            ),
          ),
          style: new ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(color!),
            shadowColor:
            MaterialStateProperty.all<Color>(Colors.transparent),
            padding: MaterialStateProperty.all(EdgeInsets.only(
              left: 10, right: 10)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                )),
          ),
          key: this.key,
        );

        break;
      case ZButtonType.isOutlined:
        _zButton = new ElevatedButton(
          onPressed: (){
            if(this.onPressed != null){
              this.onPressed!();
            }
          },
          child: new Container(
            padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (this.iconLeft != null)
                    ? new Container(child: this.iconLeft)
                    : new Container(),
                new Container(
                  padding: const EdgeInsets.only(right: 6, left: 6),
                  child: new Text(
                    this.text != null ? this.text! : "",
                    style: TextStyle(color: textColor, fontSize: 20.0),
                  ),
                ),
                (this.iconRight != null)
                    ? new Container(child: this.iconRight)
                    : new Container(),
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(30.0),
                border: Border.all(color: textColor!)),
          ),
          style: new ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.transparent),
            shadowColor:
            MaterialStateProperty.all<Color>(Colors.transparent),
            padding: MaterialStateProperty.all(EdgeInsets.only(
              left: 10, right: 10)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                )),
          ),
          key: this.key,
        );
        break;
      case ZButtonType.isTextButton:
        _zButton = new Container(
          child: new InkWell(
            borderRadius: new BorderRadius.all(const Radius.circular(25.0)),
            splashColor: const Color(0xffe6e6e6),
            onTap: (){
              if(this.onPressed !=null){
                this.onPressed!();
              }
            },
            child: new Container(
              padding: const EdgeInsets.all(12),
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  (this.iconLeft != null)
                      ? new Container(child: this.iconLeft)
                      : new Container(),
                  new Container(
                    padding: const EdgeInsets.only(right: 6, left: 6),
                    child: new Text(
                      this.text != null ? this.text!: "",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  (this.iconRight != null)
                      ? new Container(child: this.iconRight)
                      : new Container(),
                ],
              ),
            ),
          ),
          margin: const EdgeInsets.only(bottom: 8),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _zButton!;
  }
}

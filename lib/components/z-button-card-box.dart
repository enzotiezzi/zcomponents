import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZButtonCardBox extends StatefulWidget {
  final Icon? icon;
  final Text? text;
  final Color? colorText;
  final bool? isCenter;
  final double? radius;
  final double? elevation;
  final Function? onClick;

  ZButtonCardBox(
      {@required this.icon,
      @required this.text,
      this.colorText = Colors.black,
      Key? key,
      this.onClick,
      this.isCenter = false,
      this.elevation = 1.0,
      this.radius = 6});

  @override
  State<StatefulWidget> createState() => _ZButtonCardBoxState();
}

class _ZButtonCardBoxState extends State<ZButtonCardBox> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Container(
            height: 82,
            child: new Card(
                elevation: widget.elevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius!),
                ),
                child: new InkWell(
                    borderRadius: BorderRadius.circular(widget.radius!),
                    onTap: (){
                      if(widget.onClick != null){
                        widget.onClick!();
                      }
                    },
                    child: new Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: new Column(
                        crossAxisAlignment: (widget.isCenter == false)
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            child: widget.icon,
                          ),
                          new Container(
                            padding: const EdgeInsets.only(top: 6),
                            child: widget.text,
                          )
                        ],
                      ),
                    ))),
          ),
        )
      ],
    );
  }
}

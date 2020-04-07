import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-radio-group/z-radio-group-view.dart';
import 'package:z_components/components/z-radio-group/z-radio-item.dart';
import 'package:z_components/styles/main-style.dart';

class ZRadioGroup extends StatefulWidget {
  String title;
  List<ZRadioItem> itens;
  Function(String) onChange;
  Color selectColor;
  int groupValue;

  ZRadioGroup(
      {@required this.title,
      @required this.itens,
      @required this.groupValue,
      this.selectColor: const Color(0xff2bbab4),
      this.onChange});

  @override
  State<StatefulWidget> createState() => _ZRadioGroupState();
}

class _ZRadioGroupState extends State<ZRadioGroup>
    with AfterLayoutMixin<ZRadioGroup> {
  ZRadioGroupView _view;

  @override
  void initState() {
    super.initState();

    _view = new ZRadioGroupView(this);
    _view.initView();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide( //                   <--- left side
            color: Colors.black,
            width: 0.5,
          ),
          top: BorderSide( //                    <--- top side
            color: Colors.black,
            width: 0.5,
          ),
        ),
      ),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width*0.82,
                margin: const EdgeInsets.only(left: 16,top: 16,bottom: 6),
                child: new Text(
                  widget.title,
                  style: MainStyle.get(context).mainStyleTextTitle,
                ),
              )
            ],
          ),
          new GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 4.0,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(widget.itens.length, (index) {
              var item = widget.itens[index];

              return new Row(
                children: <Widget>[
                  new Radio(
                      value: item.checked ? 1 : 0,
                      groupValue: widget.groupValue,
                      activeColor: widget.selectColor,
                      onChanged: (value) => _view.onChange(value, item)),
                  new Text(
                    "${item.description}",
                    style: new TextStyle(
                        fontSize: MainStyle.get(context).fontSizePadrao),
                  )
                ],
              );
            }),
          )
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _view.afterBuild();
  }
}

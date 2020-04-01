import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-radio-group/z-radio-group-view.dart';
import 'package:z_components/components/z-radio-group/z-radio-item.dart';

class ZRadioGroup extends StatefulWidget {
  String title;
  List<ZRadioItem> itens;
  Function(String) onChange;
  int groupValue;

  ZRadioGroup(
      {@required this.title,
      @required this.itens,
      @required this.groupValue,
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
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Text("${widget.title}"),
        new Expanded(child: new GridView.count(
          crossAxisCount: 2,
          children: List.generate(widget.itens.length, (index) {
            var item = widget.itens[index];

            return new Row(
              children: <Widget>[
                new Radio(
                    value: item.checked ? 0 : 1,
                    groupValue: widget.groupValue,
                    onChanged: (value) => _view.onChange(value, item)),
                new Text("${item.description}")
              ],
            );
          }),
        ))
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _view.afterBuild();
  }
}

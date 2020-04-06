import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:z_components/components/z-checkbox/z-checkbox-view.dart';
import 'package:z_components/view-model/z-checkbox-viewmodel.dart';

class ZCheckBox extends StatefulWidget {
  List<ZCheckBoxViewModel> listaDescricao;
  String title;
  Function(List<String>) onChange;

  ZCheckBox(
      {@required this.listaDescricao,
      @required this.title,
      @required this.onChange});

  @override
  _ZCheckBoxState createState() => _ZCheckBoxState();
}

class _ZCheckBoxState extends State<ZCheckBox>
    with AfterLayoutMixin<ZCheckBox> {
  ZCheckBoxView _view;

  @override
  void initState() {
    _view = ZCheckBoxView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 60;
    var _aspectRatio = _width / cellHeight;

    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            width: 130,
            padding: EdgeInsets.only(left: 14.0, top: 14.0),
            child: new Text(
              "${widget.title}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          new Expanded(
            child: new GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount,
                    childAspectRatio: _aspectRatio),
                itemCount: widget.listaDescricao.length,
                itemBuilder: (context, index) {
                  var item = widget.listaDescricao[index];

                  return new Row(
                    children: <Widget>[
                      new Checkbox(
                          value: item.foiMarcado,
                          onChanged: (value) => _view.onChange(value, item)),
                      new Text("${item.descricao}")
                    ],
                  );
                }),
          )
        ]);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _view.afterBuild();
  }
}

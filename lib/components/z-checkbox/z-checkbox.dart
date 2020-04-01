import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:z_components/components/z-checkbox/z-checkbox-view.dart';
import 'package:z_components/styles/main-style.dart';

class ZCheckBox extends StatefulWidget {
  List<String> listaDescricao;

  ZCheckBox(this.listaDescricao);

  @override
  _ZCheckBoxState createState() => _ZCheckBoxState();
}

class _ZCheckBoxState extends State<ZCheckBox> {
  ZCheckBoxView _view;

  @override
  void initState() {
    _view = ZCheckBoxView(this);
    _view.initView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context)
        .getDefaultScaffold("CheckBox", _buildBody());
  }

  Widget _buildBody() {
    if (_view.listaCheck == null || _view.listaCheck.length == 0) {
      return new Container();
    } else {
      return new Container(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _view.listaCheck.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 20.0, mainAxisSpacing: 20.0, crossAxisCount: 2),
          itemBuilder: (context, index) {
            return new GestureDetector(
              child: new Container(
                color: Colors.white,
                child: new Row(
                  children: <Widget>[
                    new Checkbox(
                        value: _view.listaCheck[index].foiMarcado,
                        onChanged: (bool) {}),
                    new Container(
                      child: new Text(_view.listaCheck[index].descricao),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}

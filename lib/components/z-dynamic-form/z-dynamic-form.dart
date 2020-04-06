import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-dynamic-form/z-dynamic-form-view.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/z-dynamic-form-viewmodel.dart';

class ZDyanmicForm extends StatefulWidget{
  final String title;
  final List<ZDynamicFormViewModel> fields;
  final Function clickButtonEnviar;

  ZDyanmicForm({@required this.title, @required this.fields,this.clickButtonEnviar});

  @override
  State<StatefulWidget> createState() => _ZDynamicFormState();
}

class _ZDynamicFormState extends State<ZDyanmicForm> with AfterLayoutMixin<ZDyanmicForm>{
  ZDynamicFormView _view;

  @override
  void initState() {
    super.initState();

    _view = new ZDynamicFormView(this);
    _view.initView();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.get(context).getDefaultScaffold(widget.title, _buildBody());
  }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        _view.buildDynamicForm(),
        _buildBotaoEnviar()
      ],
    );
}

  Widget _buildBotaoEnviar(){
    return new RaisedButton(
      onPressed: widget.clickButtonEnviar,
      child: new Container(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: new Text(
                "ENVIAR",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      color: Color(0xff2bbab4),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      padding: const EdgeInsets.only(left: 10, right: 10),
      splashColor: Colors.grey.withOpacity(0.5),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _view.afterBuild();
  }
}


import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-dynamic-form/z-dynamic-form-view.dart';
import 'package:z_components/styles/main-style.dart';
import 'package:z_components/view-model/z-dynamic-form-viewmodel.dart';

class ZDyanmicForm extends StatefulWidget{
  final String title;
  final List<ZDynamicFormViewModel> fields;

  ZDyanmicForm({@required this.title, @required this.fields});

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
    return _view.buildDynamicForm();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _view.afterBuild();
  }
}
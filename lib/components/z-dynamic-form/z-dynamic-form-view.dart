import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/components/z-collection-item.dart';
import 'package:z_components/components/z-collection.dart';
import 'package:z_components/components/z-dynamic-form/z-dynamic-form.dart';
import 'package:z_components/components/z-input-cpf.dart';
import 'package:z_components/components/z-radio-group/z-dynamic-form-type.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/z-dynamic-form-viewmodel.dart';

class ZDynamicFormView extends IView<ZDyanmicForm> {
  Map json;

  ZDynamicFormView(State<ZDyanmicForm> state) : super(state);

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    return null;
  }

  @override
  Future<void> initView() {
    json = new Map();
  }

  Widget buildDynamicForm() {
    var widgets = state.widget.fields.map<Widget>((x) {
      switch (x.tipo) {
        case ZDynamicFormType.SELECT:
          return _buildSelect(x);
          break;
        case ZDynamicFormType.CPF:
          return _buildCPF(x);
          break;
      }

      return new Container();
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: new ListView(
        children: widgets,
      ),
    );
  }

  Widget _buildSelect(ZDynamicFormViewModel item) {
    return new ZCollection(
      titulo: item.label,
      lista: item.opcoes
          .split('|')
          .map((x) =>
              new ZCollectionItem(chave: item.nomeCampo, titulo: x, valor: x))
          .toList(),
      onChange: (value) => json[item.nomeCampo] = value,
    );
  }

  Widget _buildCPF(ZDynamicFormViewModel item) {
    TextEditingController textEditingController = new TextEditingController();
    FocusNode focusNode = new FocusNode();
    return new ZInputCPF(
      controllerCpf: textEditingController,
      cpfFocus: focusNode,
      onChange: (value) => json[item.nomeCampo] = value,
    );
  }
}

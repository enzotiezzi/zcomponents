import 'package:flutter/material.dart';
import 'package:z_components/components/z-checkbox/z-checkbox.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/z-checkbox-viewmodel.dart';

class ZCheckBoxView extends IView<ZCheckBox> {
  List<ZCheckBoxViewModel>? listaCheck;
  List<String>? listaSelecionados;

  ZCheckBoxView(State<ZCheckBox> state) : super(state);


  @override
  Future<void> initView() {
    listaCheck = [];
    listaSelecionados = [];
    throw UnimplementedError();
  }

  void onChange(bool isChecked, ZCheckBoxViewModel item) {
    if (state.mounted) {
      if (isChecked) {
        listaSelecionados?.add(item.value!);
      } else {
        for (int i = 0; i < listaSelecionados!.length; i++) {
          if (listaSelecionados![i] == item.value) {
            listaSelecionados?.removeAt(i);
          }
        }
      }
      state.setState(() {
        item.foiMarcado = isChecked;
      });
    }
    if (state.widget.onChange != null) state.widget.onChange!(listaSelecionados!);
  }

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }
}

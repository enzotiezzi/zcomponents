import 'package:flutter/material.dart';
import 'package:z_components/components/z-checkbox/z-checkbox.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/z-checkbox-viewmodel.dart';

class ZCheckBoxView extends IView<ZCheckBox> {
  List<ZCheckBoxViewModel> listaCheck;

  ZCheckBoxView(State<ZCheckBox> state) : super(state);

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    return null;
  }

  @override
  Future<void> initView() {
    listaCheck = List<ZCheckBoxViewModel>();
    _montarViewModel();
  }

  void _montarViewModel() {
    state.widget.listaDescricao.forEach((x) => listaCheck
        .add(new ZCheckBoxViewModel(descricao: x, foiMarcado: false)));
  }
}

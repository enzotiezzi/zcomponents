import 'dart:async';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-form/presenter/z-form.dart';
import 'package:z_components/i-view.dart';

class ZFormView extends IView<ZForm> {

  Map<String, String>? camposMapeados = {};
  ScrollController? scrollControllerTudo = new ScrollController();

  ZFormView(State<ZForm> state) : super(state);

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() async {
    _inicializarListaRespostas();
  }

  void _inicializarListaRespostas() {

    for (int i = 0; i < state.widget.viewmodel!.length; i++) {

    }

    if (state.mounted) state.setState(() {});
  }

  bool isValidDate(String input) {
    final date = DateTime.parse(input);
    final originalFormatString = toOriginalFormatString(date);
    return input == originalFormatString;
  }

  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$y-$m-$d";
  }
}

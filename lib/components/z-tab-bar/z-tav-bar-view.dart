

import 'package:flutter/material.dart';
import 'package:z_components/components/z-tab-bar/z-tab-bar.dart';

import '../../i-view.dart';

class ZTabBarView extends IView<ZTabBar> {
  ZTabBarView(State<ZTabBar> state) : super(state);



  @override
  Future<void> initView() async{
    _inicializarTab();
  }

  void _inicializarTab() {
    for (int i = 0; i < state.widget.listaZTabBarViewModel!.length; i++) {
      if (state.widget.listaZTabBarViewModel![i].enable!) {
        state.widget.listaZTabBarViewModel![i].selecionado = true;
        break;
      }
    }
  }

  Color corTexto(bool? selecionado, bool? enable) {
    if (selecionado != null && selecionado) {
      return state.widget.color!;
    } else if (enable != null && !enable) {
      return Color(0xffA3A3A3);
    } else {
      return Colors.black;
    }
  }

  void selecionarItem(int index) {
    if (state.widget.listaZTabBarViewModel![index].enable!) {
      state.widget.listaZTabBarViewModel![index].selecionado = true;

      for (int i = 0; i < state.widget.listaZTabBarViewModel!.length; i++) {
        if (i != index) {
          state.widget.listaZTabBarViewModel![i].selecionado = false;
        }
      }
      if (state.mounted) {
        state.setState(() {
          state.widget.onChanged!(index);
        });
      }
    }
  }

  @override
  Future<void> afterBuild() async{
  }
}

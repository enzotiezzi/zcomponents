import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/components/listagem-contas/detalhe-conta.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';

import '../../i-view.dart';

class DetalheContaViewModel extends IView<DetalheConta> {
  DetalheContaViewModel(State<DetalheConta> state) : super(state);

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }

  @override
  Future<void> initView() {}

  String listarAppsVinculados(List<AppUsuarioContaViewModel> lista) {
    String appsFormatados = "";
    if (lista != null && lista.length != 0) {
      for (int i = 0; i < lista.length; i++) {
        if (i == 0) {
          appsFormatados = "$appsFormatados- ${lista[i].app.nome ?? ""}";
        } else {
          appsFormatados = "$appsFormatados, ${lista[i].app.nome ?? ""}";
        }
      }
    } else {
      appsFormatados = "Sem apps vinculados";
    }
    return appsFormatados;
  }
}

import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'listagem-apps.dart';

class ListagemAppsView extends IView<ListagemApps> {
  ListagemAppsView(State<ListagemApps> state) : super(state);

  bool icons2 = true;

  @override
  Future<void> afterBuild() {
    // TODO: implement afterBuild
    throw UnimplementedError();
  }


  String listarAppsVinculados(List<AppUsuarioContaViewModel> lista) {
    String appsFormatados = "";
    if (lista != null && lista.length != 0) {
      for (int i = 0; i < lista.length; i++) {
        if (i == 0) {
          appsFormatados = "$appsFormatados- ${lista[i].app?.nomeExibicao}";
        } else {
          appsFormatados = "$appsFormatados, ${lista[i].app?.nomeExibicao}";
        }
      }
    } else {
      appsFormatados = "Sem apps vinculados";
    }
    return appsFormatados;
  }

  @override
  Future<void> initView() {
    // TODO: implement initView
    throw UnimplementedError();
  }
}

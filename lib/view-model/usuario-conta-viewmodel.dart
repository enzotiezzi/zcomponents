import 'package:z_components/view-model/usuario-adm-viewmodel.dart';

import 'app-usuario-conta-viewmodel.dart';

class UsuarioContaViewModel {
  String idConta;
  String idUsuario;
  List<AppUsuarioContaViewModel> appLista;
  String status;
  bool ativo;
  bool contaLogada;
  String dataVinculo;
  UsuarioAdmViewModel usuario;
  int appQtde;

  UsuarioContaViewModel(
      {this.idConta,
      this.idUsuario,
      this.appLista,
      this.status,
      this.ativo,
      this.contaLogada,
      this.dataVinculo,
      this.usuario,
      this.appQtde});

  static UsuarioContaViewModel fromJson(Map<String, dynamic> json) {
    return new UsuarioContaViewModel(
        idConta: json["idConta"],
        idUsuario: json["idUsuario"],
        appLista: (json['appLista'] != null)
            ? (json['appLista'] as List)
                .map((x) => AppUsuarioContaViewModel.fromJson(x))
                .toList()
            : List(),
        status: json["status"],
        ativo: json["ativo"],
        contaLogada: json["contaLogada"],
        dataVinculo: json["dataVinculo"],
        usuario: UsuarioAdmViewModel.fromJson(
          json['usuario'],
        ),
        appQtde: json["appQtde"]);
  }
}

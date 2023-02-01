import 'package:z_components/view-model/usuario-adm-viewmodel.dart';

import 'app-usuario-conta-viewmodel.dart';

class UsuarioContaViewModel {
  String? idConta;
  String? idUsuario;
  List<AppUsuarioContaViewModel>? appLista;
  String? status;
  bool? ativo;
  bool? contaLogada;
  String? dataVinculo;
  String? perfil;
  UsuarioAdmViewModel? usuario;
  int? appQtde;

  UsuarioContaViewModel(
      {this.idConta,
      this.idUsuario,
      this.appLista,
      this.status,
      this.ativo,
      this.contaLogada,
      this.dataVinculo,
      this.perfil,
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
            : [],
        status: json["status"],
        ativo: json["ativo"],
        contaLogada: json["contaLogada"],
        dataVinculo: json["dataVinculo"],
        perfil: json["perfil"],
        usuario: UsuarioAdmViewModel.fromJson(
          json['usuario'],
        ),
        appQtde: json["appQtde"]);
  }

  Map toMap(){
    return {
      "idConta":this.idConta,
      "idUsuario":this.idUsuario,
      "appLista":this.appLista,
      "status":this.status,
      "ativo":this.ativo,
      "contaLogada":this.contaLogada,
      "dataVinculo":this.dataVinculo,
      "perfil":this.perfil,
      "usuario":this.usuario?.toMap(),
      "appQtde":this.appQtde

    };
  }
}

import 'package:z_components/view-model/app-view-model.dart';
import 'package:z_components/view-model/usuario-adm-viewmodel.dart';

class AppUsuarioContaViewModel {
  String idApp;
  String idUsuario;
  String idConta;
  String status;
  String dataVinculo;
  String dataInativacao;
  String idPerfil;
  String tipoConta;
  bool alteraTotem;
  bool ativo;
  String token;
  UsuarioAdmViewModel usuario;
  AppViewModel app;

  AppUsuarioContaViewModel(
      {this.idApp,
      this.idUsuario,
      this.idConta,
      this.status,
      this.dataVinculo,
      this.dataInativacao,
      this.idPerfil,
      this.tipoConta,
      this.alteraTotem,
      this.ativo,
      this.token,
      this.usuario,
      this.app});

  factory AppUsuarioContaViewModel.fromJson(Map<String, dynamic> json) {
    return new AppUsuarioContaViewModel(
        idApp: json["idApp"],
        idUsuario: json["idUsuario"],
        idConta: json["idConta"],
        status: json["status"],
        dataVinculo: json["dataVinculo"],
        dataInativacao: json["dataInativacao"],
        ativo: json["ativo"],
        token: json["token"],
        usuario: UsuarioAdmViewModel.fromJson(json['usuario']),
        app: AppViewModel.fromJson(json['app']));
  }

  Map toMap() {
    return {
      "idApp": this.idApp,
      "idUsuario": this.idUsuario,
      "idConta": this.idConta,
      "status": this.status,
      "dataVinculo": this.dataVinculo,
      "dataInativacao": this.dataInativacao,
      "idPerfil": this.idPerfil,
      "tipoConta": this.tipoConta,
      "ativo": this.ativo,
      "token": this.token,
      "usuario": this.usuario.toMap(),
      "app": this.app.toMap(),
    };
  }
}

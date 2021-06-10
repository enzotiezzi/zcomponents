import 'package:z_components/view-model/app-view-model.dart';
import 'package:z_components/view-model/perfil-viewmodel.dart';
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
  PerfilViewModel perfil;
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
      this.perfil,
      this.app});

  static AppUsuarioContaViewModel fromJson(Map<String, dynamic> json) {
    return new AppUsuarioContaViewModel(
        idApp: json["idApp"],
        idUsuario: json["idUsuario"],
        idConta: json["idConta"],
        status: json["status"],
        dataVinculo: json["dataVinculo"],
        dataInativacao: json["dataInativacao"],
        ativo: json["ativo"],
        token: json["token"],
        perfil: (json['perfil'] == null)
            ? new PerfilViewModel()
            : PerfilViewModel.fromJson(json['perfil']),
        usuario: (json['usuario'] == null)
            ? new UsuarioAdmViewModel()
            : UsuarioAdmViewModel.fromJson(json['usuario']),
        app: (json['app'] == null)
            ? new AppViewModel()
            : AppViewModel.fromJson(json['app']));
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
      "perfil":this.perfil.toMap()
    };
  }
}

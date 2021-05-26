import 'app-usuario-conta-viewmodel.dart';

class UsuarioContaViewModel {
  String idConta;
  String idUsuario;
  String nomeConta;
  String nomeUsuario;
  String email;
  String telefone;
  List<AppUsuarioContaViewModel> appLista;
  String status;
  bool ativo;
  bool contaLogada;
  String dataVinculo;

  UsuarioContaViewModel({
    this.idConta,
    this.idUsuario,
    this.nomeConta,
    this.nomeUsuario,
    this.email,
    this.telefone,
    this.appLista,
    this.status,
    this.ativo,
    this.contaLogada,
    this.dataVinculo,
  });

 static  UsuarioContaViewModel fromJson(Map<String, dynamic> json) {
    return new UsuarioContaViewModel(
        idConta: json["idConta"],
        idUsuario: json["idUsuario"],
        nomeConta: json["nomeConta"],
        nomeUsuario: json["nomeUsuario"],
        email: json["email"],
        telefone: json["telefone"],
        appLista: (json['appLista'] != null)
            ? (json['appLista'] as List)
            .map((x) => AppUsuarioContaViewModel.fromJson(x))
            .toList()
            : List(),
        status: json["status"],
        ativo: json["ativo"],
        contaLogada: json["contaLogada"],
        dataVinculo: json["dataVinculo"]);
  }
}

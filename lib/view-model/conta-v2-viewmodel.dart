import 'app-usuario-conta-viewmodel.dart';
import 'conta.dart';

class ContaV2ViewModel {
  String? idConta;
  String? idUsuario;
  String? nomeConta;
  String? nomeUsuario;
  String? email;
  String? telefone;
  List<dynamic>? appLista;
  String? status;
  bool? ativo;
  bool? contaLogada;
  String? dataVinculo;
  Conta? conta;

  ContaV2ViewModel(
      {this.idConta,
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
      this.conta});

  static ContaV2ViewModel fromJson(Map<String, dynamic> json) {
    return new ContaV2ViewModel(
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
          : [],
      status: json["status"],
      ativo: json["ativo"],
      contaLogada: json["contaLogada"],
      dataVinculo: json["dataVinculo"],
      conta: Conta.fromJson(
        json['conta'],
      ),
    );
  }

  Map toMap() {
    return {
      "idConta": this.idConta,
      "idUsuario": this.idUsuario,
      "nomeConta": this.nomeConta,
      "nomeUsuario": this.nomeUsuario,
      "email": this.email,
      "telefone": this.telefone,
      "appLista": this.appLista,
      "status": this.status,
      "ativo": this.ativo,
      "contaLogada": this.contaLogada,
      "dataVinculo": this.dataVinculo,
    };
  }
}

import 'dart:typed_data';

class Conta {
  String idConta;
  String nome;
  String nomeFantasia;
  Uint8List logo;

  Conta({this.nome, this.idConta, this.nomeFantasia, this.logo});

  factory Conta.fromJson(Map<String, dynamic> json) {
    return new Conta(
        nome: json["nome"],
        idConta: json["idConta"],
        nomeFantasia: json["nomeFantasia"]);
  }
}

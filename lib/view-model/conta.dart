import 'dart:typed_data';

class Conta {
  String? idConta;
  String? nome;
  String? nomeFantasia;
  Uint8List? logo;
  String? corPrimaria;
  String? corSecundaria;

  Conta(
      {this.nome,
      this.idConta,
      this.nomeFantasia,
      this.logo,
      this.corPrimaria,
      this.corSecundaria});

  factory Conta.fromJson(Map<String, dynamic> json) {
    return new Conta(
        nome: json["nome"],
        idConta: json["idConta"],
        nomeFantasia: json["nomeFantasia"],
        corPrimaria: json["corPrimaria"],
        corSecundaria: json["corSecundaria"]);
  }
}

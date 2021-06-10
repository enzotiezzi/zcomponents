class Conta {
  String idConta;
  String nome;
  String nomeFantasia;

  Conta({this.nome, this.idConta, this.nomeFantasia});

  factory Conta.fromJson(Map<String, dynamic> json) {
    return new Conta(
        nome: json["nome"],
        idConta: json["idConta"],
        nomeFantasia: json["nomeFantasia"]);
  }
}

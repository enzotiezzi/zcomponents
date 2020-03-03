class TokenInfo {
  String idUser;
  String idColaborador;
  String idConta;
  String cpf;
  String email;
  String nome;

  TokenInfo(
      {this.idUser,
      this.idColaborador,
      this.idConta,
      this.cpf,
      this.email,
      this.nome});

  factory TokenInfo.fromJson(Map<String, dynamic> json) {
    return new TokenInfo(
        idUser: json["sub"],
        idColaborador: json["idColaborador"],
        idConta: json["idAccount"],
        cpf: json["preferred_username"],
        email: json["email"],
        nome: json["name"]);
  }
}

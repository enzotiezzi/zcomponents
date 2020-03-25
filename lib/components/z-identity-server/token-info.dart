class TokenInfo {
  String idUser;
  String idColaborador;
  String idConta;
  String cpf;
  String email;
  String nome;
  String telefone;

  TokenInfo(
      {this.idUser,
      this.idColaborador,
      this.idConta,
      this.cpf,
      this.email,
      this.nome,
      this.telefone});

  factory TokenInfo.fromJson(Map<String, dynamic> json) {
    return new TokenInfo(
        idUser: json["sub"],
        idColaborador: json["idColaborador"],
        idConta: json["idAccount"],
        cpf: json["preferred_username"],
        email: json["email"],
        nome: json["name"],
        telefone: json["telefone"]);
  }
}

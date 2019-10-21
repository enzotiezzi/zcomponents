class UserClaims {
  String idUser;
  String idColaborador;
  String conta;
  String idConta;
  String cpf;

  UserClaims(
      {this.idUser, this.idColaborador, this.conta, this.idConta, this.cpf});

  factory UserClaims.fromJson(Map<String, dynamic> json) {
    return new UserClaims(
        idUser: json["sub"],
        idColaborador: json["idColaborador"],
        conta: json["account"],
        idConta: json["idAccount"],
        cpf: json["name"]);
  }
}

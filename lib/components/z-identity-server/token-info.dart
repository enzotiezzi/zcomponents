class UserInfo {
  String idUser;
  String idColaborador;
  String idConta;
  String cpf;
  String email;
  String nome;
  String telefone;
  String dataNascimento;
  String logradouro;
  String bairro;
  String cidade;
  String estado;
  String cep;
  String numero;
  String idFoto;
  String fotoBase64;

  UserInfo(
      {this.idUser,
        this.idColaborador,
        this.idConta,
        this.cpf,
        this.email,
        this.nome,
        this.telefone,
        this.bairro,
        this.cep,
        this.cidade,
        this.dataNascimento,
        this.estado,
        this.logradouro,
        this.numero,
        this.idFoto,
        this.fotoBase64});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return new UserInfo(
        idUser: json["sub"],
        idColaborador: json["idColaborador"],
        idConta: json["idAccount"],
        cpf: json["preferred_username"],
        email: json["email"],
        nome: json["name"],
        telefone: json["telefone"],
        bairro: json["bairro"],
        cep: json["cep"],
        cidade: json["cidade"],
        dataNascimento: json["dataNascimento"],
        estado: json["estado"],
        logradouro: json["logradouro"],
        idFoto: json["idFoto"]);
  }

  Map toMap(){
    return {
      "idUser": this.idUser,
      "idColaborador": this.idColaborador,
      "idConta": this.idConta,
      "cpf": this.cpf,
      "email": this.email,
      "nome": this.nome,
      "telefone": this.telefone,
      "dataNascimento": this.dataNascimento,
      "logradouro": this.logradouro,
      "bairro": this.bairro,
      "cidade": this.cidade,
      "cep": this.cep,
      "estado": this.estado,
      "numero": this.numero
    };
  }
}
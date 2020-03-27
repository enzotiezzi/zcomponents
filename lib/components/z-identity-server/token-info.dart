class UserInfo {
  String idUsuario;
  String username;
  String cpf;
  String email;
  String nome;
  String idPessoa;
  String nomeSocial;
  String telefone;
  String celular;
  String dataNascimento;
  String logradouro;
  String numero;
  String complemento;
  String bairro;
  String cidade;
  String estado;
  String cep;
  String idFoto;
  String fotoBase64;
  String idConta;

  UserInfo(
      {this.idUsuario,
      this.username,
      this.cpf,
      this.email,
      this.nome,
      this.idPessoa,
      this.nomeSocial,
      this.telefone,
      this.celular,
      this.dataNascimento,
      this.logradouro,
      this.numero,
      this.complemento,
      this.bairro,
      this.cidade,
      this.estado,
      this.cep,
      this.idFoto,
      this.fotoBase64,
      this.idConta});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return new UserInfo(
      idUsuario: json["IDUSUARIO"],
      username: json["USERNAME"],
      cpf: json["CPF"],
      email: json["EMAIL"],
      nome: json["NOME"],
      idPessoa: json["IDPESSOA"],
      nomeSocial: json["NOMESOCIAL"],
      telefone: json["TELEFONE"],
      celular: json["CELULAR"],
      dataNascimento: json["DATANASCIMENTO"],
      logradouro: json["LOGRADOURO"],
      numero: json["NUMERO"],
      complemento: json["COMPLEMENTO"],
      bairro: json["BAIRRO"],
      cidade: json["CIDADE"],
      estado: json["ESTADO"],
      cep: json["CEP"],
      idFoto: json["IDFOTO"],
      fotoBase64: json["FOTOBASE64"],
      idConta: json["idAccount"]
    );
  }

  Map toMap() {
    return {
      "IDUSUARIO": idUsuario,
      "USERNAME": username,
      "CPF": cpf,
      "EMAIL": email,
      "NOME": nome,
      "IDPESSOA": idPessoa,
      "NOMESOCIAL": nomeSocial,
      "TELEFONE": telefone,
      "CELULAR": celular,
      "DATANASCIMENTO": dataNascimento,
      "LOGRADOURO": logradouro,
      "NUMERO": numero,
      "COMPLEMENTO": complemento,
      "BAIRRO": bairro,
      "CIDADE": cidade,
      "ESTADO": estado,
      "CEP": cep,
      "IDFOTO": idFoto,
      "FOTOBASE64": fotoBase64,
      "idAccount": idConta,
    };
  }
}

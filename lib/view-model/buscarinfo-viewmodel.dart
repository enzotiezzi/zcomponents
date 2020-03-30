class BuscarInfo {
  String idUsuario;
  String username;
  String cPF;
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
  String cEP;
  String idFoto;
  String fotoBase64;

  BuscarInfo({
    this.idUsuario,
    this.username,
    this.cPF,
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
    this.cEP,
    this.idFoto,
    this.fotoBase64,
  });

  factory BuscarInfo.fromJson(Map<String, dynamic> json) {
    return new BuscarInfo(
      idUsuario: json["idUsuario"],
      username: json["username"],
      cPF: json["cPF"],
      email: json["email"],
      nome: json["nome"],
      idPessoa: json["idPessoa"],
      nomeSocial: json["nomeSocial"],
      telefone: json["telefone"],
      celular: json["celular"],
      dataNascimento: json["dataNascimento"],
      logradouro: json["logradouro"],
      numero: json["numero"],
      complemento: json["complemento"],
      bairro: json["bairro"],
      cidade: json["cidade"],
      estado: json["estado"],
      cEP: json["cEP"],
      idFoto: json["idFoto"],
      fotoBase64: json["fotoBase64"],
    );
  }

  Map toMap() {
    return {
      "idUsuario": idUsuario,
      "username": username,
      "cPF": cPF,
      "email": email,
      "nome": nome,
      "idPessoa": idPessoa,
      "nomeSocial": nomeSocial,
      "telefone": telefone,
      "celular": celular,
      "dataNascimento": dataNascimento,
      "logradouro": logradouro,
      "numero": numero,
      "complemento": complemento,
      "bairro": bairro,
      "cidade": cidade,
      "estado": estado,
      "cEP": cEP,
      "idFoto": idFoto,
      "fotoBase64": fotoBase64,
    };
  }
}

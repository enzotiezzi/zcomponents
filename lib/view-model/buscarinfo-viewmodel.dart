import 'dart:typed_data';

class BuscarInfo {
  String idUsuario;
  String username;
  String cpf;
  String email;
  String nome;
  String nomeReduzido;
  String idPessoa;
  String telefone;
  String celular;
  String dataNascimento;
  String idFoto;
  Uint8List fotoBase64;


  BuscarInfo(
      {this.idUsuario,
      this.username,
      this.cpf,
      this.email,
      this.nome,
      this.nomeReduzido,
      this.idPessoa,
      this.telefone,
      this.celular,
      this.dataNascimento,
      this.idFoto,
      this.fotoBase64,
  });

  factory BuscarInfo.fromJson(Map<String, dynamic> json) {
    return new BuscarInfo(
        idUsuario: json["idUsuario"],
        username: json["username"],
        cpf: json["cpf"],
        email: json["email"],
        nome: json["nome"],
        nomeReduzido: json["nomeReduzido"],
        idPessoa: json["idPessoa"],
        telefone: json["telefone"],
        celular: json["celular"],
        dataNascimento: json["dataNascimento"],
        idFoto: json["idFoto"],
        fotoBase64: json["fotoBase64"],
      );
  }

  Map toMap() {
    return {
      "idUsuario": idUsuario,
      "username": username,
      "cpf": cpf,
      "email": email,
      "nome": nome,
      "nomeReduzido": nomeReduzido,
      "idPessoa": idPessoa,
      "telefone": telefone,
      "celular": celular,
      "dataNascimento": dataNascimento,
      "idFoto": idFoto,
      "fotoBase64": fotoBase64,
    };
  }
}

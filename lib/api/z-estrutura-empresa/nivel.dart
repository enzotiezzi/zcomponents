class Nivel {
  String idNivel;
  String nome;
  String idNivelPai;
  String caminho;

  // NivelTipo NivelTipo;
  String idNivelTipo;
  String tipo;

  // Endereco Endereco;
  List<Nivel> niveis;

  String rua;
  String numero;
  String complemento;
  String CEP;
  String bairro;

  // MunicipioZellar Municipio;
  String idMunicipio;

  // EstadoZellar Estado;
  String idEstado;
  String idUsuarioCriacao;

  int index;

  Nivel(
      {this.nome,
      this.niveis,
      this.idNivel,
      this.bairro,
      this.caminho,
      this.CEP,
      this.complemento,
      this.idEstado,
      this.idMunicipio,
      this.idNivelPai,
      this.idNivelTipo,
      this.idUsuarioCriacao,
      this.index,
      this.numero,
      this.rua,
      this.tipo});

  static Nivel fromJson(Map<String, dynamic> json) {
    return new Nivel(
      nome: json["nome"],
      niveis: (json["niveis"] as List).map((x) => Nivel.fromJson(x)).toList(),
      bairro: json["bairro"],
      caminho: json["caminho"],
      CEP: json["CEP"],
      complemento: json["complemento"],
      idEstado: json["idEstado"],
      idMunicipio: json["idMunicipio"],
      idNivel: json["idNivel"],
      idNivelPai: json["idNivelPai"],
      idNivelTipo: json["idNivelTipo"],
      idUsuarioCriacao: json["idUsuarioCriacao"],
      index: json["index"],
      numero: json["numero"],
      rua: json["rua"],
      tipo: json["tipo"]
    );
  }
}

class ColaboradorDocumentoInput {
  String? idColaborador;
  Map<String, int>? imagens;
  Map<String, String>? campos;

  ColaboradorDocumentoInput({
    this.idColaborador: "",
    this.imagens,
    this.campos,
  });

  factory ColaboradorDocumentoInput.fromJson(Map<String, dynamic> json) {
    return new ColaboradorDocumentoInput(
      idColaborador: json['idColaborador'],
      imagens: json['imagens'],
      campos: json['campos'],
    );
  }

  Map toMap() {
    return {
      "idColaborador": this.idColaborador,
      "imagens": this.imagens,
      "campos": this.campos,
    };
  }

}

class ColaboradorDocumentoCampoViewModel {
  String? idColaboradorDocumentoCampo;

  String? idColaboradorDocumento;

  String? idDocumentoCampo;

  String? valor;
  int? ordem;

  ColaboradorDocumentoCampoViewModel({
    this.idColaboradorDocumentoCampo,
    this.idColaboradorDocumento,
    this.idDocumentoCampo,
    this.valor,
    this.ordem,
  });

  factory ColaboradorDocumentoCampoViewModel.fromJson(
      Map<String, dynamic> json) {
    return new ColaboradorDocumentoCampoViewModel(
      idColaboradorDocumentoCampo: json['idColaboradorDocumentoCampo'],
      idColaboradorDocumento: json['idColaboradorDocumento'],
      idDocumentoCampo: json['idDocumentoCampo'],
      valor: json['valor'],
      ordem: json['ordem'],
    );
  }

  Map toMap() {
    return {
      "idColaboradorDocumentoCampo": this.idColaboradorDocumentoCampo,
      "idColaboradorDocumento": this.idColaboradorDocumento,
      "idDocumentoCampo": this.idDocumentoCampo,
      "valor": this.valor,
      "ordem": this.ordem,
    };
  }
}

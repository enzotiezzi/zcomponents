class ColaboradorDocumentoImagemViewModel {
  String idColaboradorDocumentoImagem;
  String idColaboradorDocumento;
  String idImagem;
  int numeroPagina;


  ColaboradorDocumentoImagemViewModel({
    this.idColaboradorDocumentoImagem,
    this.idColaboradorDocumento,
    this.idImagem,
    this.numeroPagina,
  });

  factory ColaboradorDocumentoImagemViewModel.fromJson(
      Map<String, dynamic> json) {
    return new ColaboradorDocumentoImagemViewModel(
      idColaboradorDocumentoImagem: json['idColaboradorDocumentoImagem'],
      idColaboradorDocumento: json['idColaboradorDocumento'],
      idImagem: json['idImagem'],
      numeroPagina: json['numeroPagina'],
    );
  }

  Map toMap() {
    return {
      "idColaboradorDocumentoImagem": this.idColaboradorDocumentoImagem,
      "idColaboradorDocumento": this.idColaboradorDocumento,
      "idImagem": this.idImagem,
      "numeroPagina": this.numeroPagina,
    };
  }
}

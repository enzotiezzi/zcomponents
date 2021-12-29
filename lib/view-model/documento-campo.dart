class DocumentoCampo {
  String idDocumentoCampo;
  String idDocumento;

  String nomeCampo;

  String tipoValorCampo;

  String tamanhoValorCampo;

  String tamanhoPrecisaoValorCampo;

  bool obrigatorio;
  String resposta;

  DocumentoCampo(
      {this.idDocumento,
      this.idDocumentoCampo,
      this.nomeCampo,
      this.obrigatorio,
      this.tamanhoPrecisaoValorCampo,
      this.tamanhoValorCampo,
      this.tipoValorCampo,
      this.resposta});

  factory DocumentoCampo.fromJson(Map<String, dynamic> json) {
    return new DocumentoCampo(
      idDocumento: json['idDocumento'],
      idDocumentoCampo: json['idDocumentoCampo'],
      nomeCampo: json['nomeCampo'],
      obrigatorio: json['obrigatorio'],
      tamanhoPrecisaoValorCampo: json['tamanhoPrecisaoValorCampo'],
      tamanhoValorCampo: json['tamanhoValorCampo'],
      tipoValorCampo: json['tipoValorCampo'],
    );
  }
}

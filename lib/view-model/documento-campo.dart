class DocumentoCampo {
  String idDocumentoCampo;
  String idDocumento;

  String nomeCampo;

  String tipoValorCampo;

  String tamanhoValorCampo;

  String tamanhoPrecisaoValorCampo;

  bool obrigatorio;
  String resposta;

  String idAtributo;
  String idModelo;
  String dataResposta;
  String modelo;
  String idTipo;
  String label;
  String tipo;

  DocumentoCampo(
      {this.idDocumento,
      this.idDocumentoCampo,
      this.nomeCampo,
      this.obrigatorio,
      this.tamanhoPrecisaoValorCampo,
      this.tamanhoValorCampo,
      this.tipoValorCampo,
      this.resposta,
      this.idAtributo,
      this.idModelo,
      this.dataResposta,
      this.modelo,
      this.idTipo,
      this.label,
      this.tipo
      });

  factory DocumentoCampo.fromJson(Map<String, dynamic> json) {
    return new DocumentoCampo(
      idDocumento: json['idDocumento'],
      idDocumentoCampo: json['idDocumentoCampo'],
      nomeCampo: json['nomeCampo'],
      obrigatorio: json['obrigatorio'],
      tamanhoPrecisaoValorCampo: json['tamanhoPrecisaoValorCampo'],
      tamanhoValorCampo: json['tamanhoValorCampo'],
      tipoValorCampo: json['tipoValorCampo'],
      idAtributo: json["idAtributo"],
      idModelo: json["idModelo"],
      dataResposta: json["dataResposta"],
      modelo: json["modelo"],
      idTipo: json["idTipo"],
      label: json["label"],
      tipo: json["tipo"],
      resposta: json["resposta"]
    );
  }
}

class ZDynamicFormViewModel {
  String? idModelo;
  String? idAtributo;
  String? idTipo;
  String? modelo;
  String? label;
  String? descricao;
  String? tipo;
  int? ordem;
  int? tamanhoMaximo;
  int? versao;
  bool? obrigatorio;
  bool? multiplaEscolha;
  String? opcoes;
  String? nomeCampo;
  String? sistema;

  ZDynamicFormViewModel({
    this.idModelo,
    this.idAtributo,
    this.idTipo,
    this.modelo,
    this.label,
    this.descricao,
    this.tipo,
    this.ordem,
    this.tamanhoMaximo,
    this.versao,
    this.obrigatorio,
    this.multiplaEscolha,
    this.opcoes,
    this.nomeCampo,
    this.sistema,
  });

  factory ZDynamicFormViewModel.fromJson(Map<String, dynamic> json) {
    return new ZDynamicFormViewModel(
      idModelo: json['idModelo'],
      idAtributo: json['idAtributo'],
      idTipo: json['idTipo'],
      modelo: json['modelo'],
      label: json['label'],
      descricao: json['descricao'],
      tipo: json['tipo'],
      ordem: json['ordem'],
      tamanhoMaximo: json['tamanhoMaximo'],
      versao: json['versao'],
      obrigatorio: json['obrigatorio'],
      multiplaEscolha: json['multiplaEscolha'],
      opcoes: json['opcoes'],
      nomeCampo: json['nomeCampo'],
      sistema: json['sistema'],
    );
  }

  Map toMap() {
    return {
      "idModelo": this.idModelo,
      "idAtributo": this.idAtributo,
      "idTipo": this.idTipo,
      "modelo": this.modelo,
      "label": this.label,
      "descricao": this.descricao,
      "tipo": this.tipo,
      "ordem": this.ordem,
      "tamanhoMaximo": this.tamanhoMaximo,
      "versao": this.versao,
      "obrigatorio": this.obrigatorio,
      "multiplaEscolha": this.multiplaEscolha,
      "opcoes": this.opcoes,
      "nomeCampo": this.nomeCampo,
      "sistema": this.sistema,
    };
  }
}

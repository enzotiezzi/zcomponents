import 'contratacao-documento-viewmodel.dart';

class ContratacaoDocumentoCampoViewModel {
  ContratacaoDocumentoViewModel contratacaoDocumento;
  String idContratacao;
  String idAtributo;
  String idDocumento;
  String resposta;
  String dataResposta;
  bool revisado;
  bool aprovado;
  String justificativaReprovacao;
  String idModelo;
  String idTipo;
  String modelo;
  String label;
  String descricao;
  String tipo;
  int ordem;
  int tamanhoMaximo;
  int versao;
  bool obrigatorio;
  bool multiplaEscolha;
  String opcoes;
  String mascara;
  String nomeCampo;
  String idConta;

  ContratacaoDocumentoCampoViewModel(
      {this.idContratacao,
        this.idAtributo,
        this.idDocumento,
        this.resposta,
        this.dataResposta,
        this.revisado,
        this.aprovado,
        this.justificativaReprovacao,
        this.idModelo,
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
        this.mascara,
        this.nomeCampo,
        this.idConta,
        this.contratacaoDocumento});

  static ContratacaoDocumentoCampoViewModel fromJson(
      Map<String, dynamic> json) {
    return new ContratacaoDocumentoCampoViewModel(
      contratacaoDocumento: (json["contratacaoDocumento"] == null)
          ? new ContratacaoDocumentoViewModel()
          : ContratacaoDocumentoViewModel.fromJson(
          json["contratacaoDocumento"]),
      idContratacao: json["idContratacao"],
      idAtributo: json["idAtributo"],
      idDocumento: json["idDocumento"],
      resposta: json['resposta'],
      dataResposta: json['dataResposta'],
      revisado: json['revisado'],
      aprovado: json['aprovado'],
      justificativaReprovacao: json['justificativaReprovacao'],
      idModelo: json['idModelo'],
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
      mascara: json['mascara'],
      nomeCampo: json['nomeCampo'],
      idConta: json['idConta'],
    );
  }

  Map toMap() {
    return {
      "idContratacao": this.idContratacao,
      "idAtributo": this.idAtributo,
      "idDocumento": this.idDocumento,
      "contratacaoDocumento": this.contratacaoDocumento.toMap(),
      'resposta': this.resposta,
      'dataResposta': this.dataResposta,
      'revisado': this.revisado,
      'aprovado': this.aprovado,
      'justificativaReprovacao': this.justificativaReprovacao,
      'idModelo': this.idModelo,
      'idTipo': this.idTipo,
      'modelo': this.modelo,
      'label': this.label,
      'descricao': this.descricao,
      'tipo': this.tipo,
      'ordem': this.ordem,
      'tamanhoMaximo': this.tamanhoMaximo,
      'versao': this.versao,
      'obrigatorio': this.obrigatorio,
      'multiplaEscolha': this.multiplaEscolha,
      'opcoes': this.opcoes,
      'mascara': this.mascara,
      'nomeCampo': this.nomeCampo,
      'idConta': this.idConta,
    };
  }
}

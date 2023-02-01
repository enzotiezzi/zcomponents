import 'contratacao-documento-campo-viewmodel.dart';
import 'contratacao-viewmodel.dart';

class ContratacaoDocumentoViewModel {
  ContratacaoViewModel? contratacao;
  String? idContratacao;
  String? idDocumento;
  String? nomeDocumento;
  int? qtdePagina;
  List<ContratacaoDocumentoCampoViewModel>? campos;
  bool? obrigatorio;
  String? idConta;
  String? idImagemDocumento;
  int? qtdePaginaObrigatoria;
  String? horizontalOuVertical;
  String? nomeCompleto;
  int? qtdeCampoTotal;
  int? qtdeCampoRespondido;
  double? percentualRespondido;
  int? qtdeCampoRevisado;
  double? percentualRevisado;
  bool? possuiReprovacao;
  int? qtdeCampoReprovado;

  ContratacaoDocumentoViewModel(
      {this.contratacao,
        this.idContratacao,
        this.idDocumento,
        this.nomeDocumento,
        this.campos,
        this.qtdePagina,
        this.obrigatorio,
        this.qtdeCampoRespondido,
        this.qtdeCampoTotal,
        this.percentualRespondido,
        this.idImagemDocumento,
        this.qtdePaginaObrigatoria,
        this.nomeCompleto,
        this.horizontalOuVertical,
        this.idConta,
        this.possuiReprovacao,
        this.qtdeCampoReprovado,
        this.qtdeCampoRevisado,
        this.percentualRevisado});

  static ContratacaoDocumentoViewModel fromJson(Map<String, dynamic> json) {
    return new ContratacaoDocumentoViewModel(
        idContratacao: json["idContratacao"],
        idDocumento: json["idDocumento"],
        nomeDocumento: json["nomeDocumento"],
        qtdePagina: json["qtdePagina"],
        obrigatorio: json["obrigatorio"],
        campos: (json["campos"] == null)
            ? []
            : (json["campos"] as List)
            .map((x) => ContratacaoDocumentoCampoViewModel.fromJson(x))
            .toList(),
        contratacao: (json["contratacao"] == null)
            ? new ContratacaoViewModel()
            : ContratacaoViewModel.fromJson(json["contratacao"]),
        qtdeCampoRespondido: json["qtdeCampoRespondido"],
        qtdeCampoTotal: json["qtdeCampoTotal"],
        percentualRespondido: json["percentualRespondido"],
        idImagemDocumento: json["idImagemDocumento"],
        qtdePaginaObrigatoria: json["qtdePaginaObrigatoria"],
        nomeCompleto: json["nomeCompleto"],
        horizontalOuVertical: json["horizontalOuVertical"],
        idConta: json["idConta"],
        possuiReprovacao: json["possuiReprovacao"],
        qtdeCampoReprovado: json["qtdeCampoReprovado"],
        qtdeCampoRevisado: json["qtdeCampoRevisado"],
        percentualRevisado: json["percentualRevisado"]);
  }

  Map toMap() {
    return {
      "contratacao":this.contratacao,
      "idContratacao": this.idContratacao,
      "idDocumento": this.idDocumento,
      "nomeDocumento": this.nomeDocumento,
      "qtdePagina": this.qtdePagina,
      "obrigatorio": this.obrigatorio,
      "idImagemDocumento": this.idImagemDocumento,
      "campos": this.campos?.map((x) => x.toMap()).toList(),
      "qtdeCampoTotal": this.qtdeCampoTotal,
      "qtdeCampoRespondido": this.qtdeCampoRespondido,
      "percentualRespondido": this.percentualRespondido,
      "idConta": this.idConta,
      "qtdePaginaObrigatoria": this.qtdePaginaObrigatoria,
      "horizontalOuVertical": this.horizontalOuVertical,
      "nomeCompleto": this.nomeCompleto,
      "qtdeCampoRevisado": this.qtdeCampoRevisado,
      "percentualRevisado": this.percentualRevisado,
      "possuiReprovacao": this.possuiReprovacao,
      "qtdeCampoReprovado": this.qtdeCampoReprovado
    };
  }
}

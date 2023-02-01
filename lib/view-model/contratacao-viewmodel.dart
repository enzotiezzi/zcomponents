import 'contratacao-status-viewmodel.dart';
import 'contratacao-validacao-viewmodel.dart';

class ContratacaoViewModel {
  String? idContratacao;
  String? idEmpresa;
  String? idCargo;
  String? idKitAdmissao;
  String? dataAdmissao;
  String? dataVencimento;
  ContratacaoStatus? contratacaoStatus;
  String? idContratacaoStatus;
  bool? preenchimentoRH;
  bool? preenchimentoCandidato;
  String? nomeCargo;
  String? nome;
  String? cpf;
  String? email;
  String? telefone;
  String? textoConvite;
  String? dataVisualizacaoCandidato;
  String? dataAprovacaoRH;
  String? dataCriacao;
  String? idUsuarioCriacao;
  double? contratacaoPercentualRespondido;
  bool? correcaoSolicitada;
  String? idContratacaoValidacaoStatus;
  ContratacaoValidacaoStatusViewModel? contratacaoValidacaoStatusViewModel;
  String? idConta;
  bool? correcaoRealizada;

  ContratacaoViewModel(
      {this.idContratacao,
        this.idEmpresa,
        this.idCargo,
        this.idKitAdmissao,
        this.dataAdmissao,
        this.dataVencimento,
        this.contratacaoStatus,
        this.idContratacaoStatus,
        this.preenchimentoRH,
        this.preenchimentoCandidato,
        this.nome,
        this.cpf,
        this.email,
        this.telefone,
        this.textoConvite,
        this.dataVisualizacaoCandidato,
        this.dataAprovacaoRH,
        this.dataCriacao,
        this.idUsuarioCriacao,
        this.nomeCargo,
        this.contratacaoPercentualRespondido,
        this.contratacaoValidacaoStatusViewModel,
        this.idContratacaoValidacaoStatus,
        this.correcaoSolicitada,
        this.idConta,
        this.correcaoRealizada});

  static ContratacaoViewModel fromJson(Map<String, dynamic> json) {
    return new ContratacaoViewModel(
      idContratacao: json["idContratacao"],
      idEmpresa: json["idEmpresa"],
      idCargo: json["idCargo"],
      idKitAdmissao: json["idKitAdmissao"],
      dataAdmissao: json["dataAdmissao"],
      dataVencimento: json["dataVencimento"],
      contratacaoStatus: (json["contratacaoStatus"] == null)
          ? new ContratacaoStatus()
          : ContratacaoStatus.fromJson(json["contratacaoStatus"]),
      idContratacaoStatus: json["idContratacaoStatus"],
      preenchimentoRH: json["preenchimentoRH"],
      preenchimentoCandidato: json["preenchimentoCandidato"],
      nome: json["nome"],
      cpf: json["cpf"],
      email: json["email"],
      telefone: json["telefone"],
      textoConvite: json["textoConvite"],
      dataVisualizacaoCandidato: json["dataVisualizacaoCandidato"],
      dataAprovacaoRH: json["dataAprovacaoRH"],
      dataCriacao: json["dataCriacao"],
      idUsuarioCriacao: json["idUsuarioCriacao"],
      nomeCargo: json["nomeCargo"],
      contratacaoPercentualRespondido:
      json["contratacaoPercentualRespondido"],
      contratacaoValidacaoStatusViewModel: (json["contratacaoValidacaoStatusViewModel"] == null)
          ? new ContratacaoValidacaoStatusViewModel()
          : ContratacaoValidacaoStatusViewModel.fromJson(json["contratacaoValidacaoStatusViewModel"],),
      correcaoSolicitada: json["correcaoSolicitada"],
      idConta: json["idConta"],
      correcaoRealizada: json["correcaoRealizada"],
      idContratacaoValidacaoStatus: json["idContratacaoValidacaoStatus"],
    );
  }

  Map toMap() {
    return {
      "idConta": this.idConta,
      "correcaoRealizada": this.correcaoRealizada,
      "idContratacao": this.idContratacao,
      "idEmpresa": this.idEmpresa,
      "idCargo": this.idCargo,
      "idKitAdmissao": this.idKitAdmissao,
      "dataAdmissao": this.dataAdmissao,
      "dataVencimento": this.dataVencimento,
      "contratacaoStatus": this.contratacaoStatus?.toMap(),
      "idContratacaoStatus": this.idContratacaoStatus,
      "preenchimentoRH": this.preenchimentoRH,
      "preenchimentoCandidato": this.preenchimentoCandidato,
      "nome": this.nome,
      "cpf": this.cpf,
      "email": this.email,
      "telefone": this.telefone,
      "textoConvite": this.textoConvite,
      "dataVisualizacaoCandidato": this.dataVisualizacaoCandidato,
      "dataAprovacaoRH": this.dataAprovacaoRH,
      "dataCriacao": this.dataCriacao,
      "idUsuarioCriacao": this.idUsuarioCriacao,
      "nomeCargo": this.nomeCargo,
      "contratacaoPercentualRespondido": this.contratacaoPercentualRespondido,
      "contratacaoValidacaoStatusViewModel": this.contratacaoValidacaoStatusViewModel?.toMap(),
      "correcaoSolicitada": this.correcaoSolicitada,
      "idContratacaoValidacaoStatus": this.idContratacaoValidacaoStatus
    };
  }
}

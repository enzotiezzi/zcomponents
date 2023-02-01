import 'package:z_components/view-model/posicao-alocacao-sequencia-viewmodel.dart';

class ColaboradorViewModel {
  String? idColaborador;
  String? rE;
  String? nomeColaborador;
  String? idCentroCusto;
  String? idPosicaoAlocacao;
  String? centroCusto;
  String? cargo;
  String? idCargo;
  String? nome;
  String? cpf;
  String? escala;
  String? idEmpresa;
  String? celular;
  String? nomeCentroCusto;
  String? primeiraFolga;
  String? idConta;
  String? horaEntrada;
  String? horaSaida;
  String? tempoPausa;

  bool? pendente;

  List<PosicaoAlocacaoSequenciaViewModel>? sequencias;

  ColaboradorViewModel({
    this.idColaborador: "",
    this.rE: "",
    this.nome: "",
    this.cpf: "",
    this.idCentroCusto: "",
    this.centroCusto: "",
    this.escala: "",
    this.nomeColaborador: "",
    this.cargo: "",
    this.idEmpresa: "",
    this.celular: "",
    this.nomeCentroCusto: "",
    this.horaEntrada: "",
    this.horaSaida: "",
    this.tempoPausa: "",
    this.idPosicaoAlocacao: "",
    this.pendente,
    this.sequencias,
    this.idCargo,
    this.primeiraFolga,
    this.idConta,
  });

  Map toMap() {
    return {
      "idColaborador": this.idColaborador,
      "rE": this.rE,
      "nome": this.nome,
      "cpf": this.cpf,
      "idCentroCusto": this.idCentroCusto,
      "centroCusto": this.centroCusto,
      "escala": this.escala,
      "nomeColaborador": this.nomeColaborador,
      "cargo": this.cargo,
      "idEmpresa": this.idEmpresa,
      "celular": this.celular,
      "nomeCentroCusto": this.nomeCentroCusto,
      "horaEntrada": this.horaEntrada,
      "horaSaida": this.horaSaida,
      "tempoPausa": this.tempoPausa,
      "idPosicaoAlocacao": this.idPosicaoAlocacao,
      "pendente": this.pendente,
      "sequenciaEscala": this.sequencias?.map((x) => x.toMap()).toList(),
      "idCargo": this.idCargo,
      "primeiraFolga": this.primeiraFolga,
      "idConta": this.idConta,
    };
  }

  factory ColaboradorViewModel.fromJson(Map<String, dynamic> json) {
    return new ColaboradorViewModel(
      idColaborador: json['idColaborador'],
      rE: json['rE'],
      nome: json['nome'],
      cpf: json['cpf'],
      centroCusto: json['centroCusto'],
      idCentroCusto: json['idCentroCusto'],
      escala: json['escala'],
      nomeColaborador: json['nomeColaborador'],
      cargo: json['cargo'],
      idEmpresa: json['idEmpresa'],
      celular: json['celular'],
      nomeCentroCusto: json['nomeCentroCusto'],
      horaEntrada: json["horaEntrada"],
      horaSaida: json["horaSaida"],
      tempoPausa: json["tempoPausa"],
      idPosicaoAlocacao: json['idPosicaoAlocacao'],
      pendente: json["pendente"],
      idCargo: json["idCargo"],
      primeiraFolga: json["primeiraFolga"],
      idConta: json["idConta"],
    );
  }
}

class ProcessoSeletivoViewModel {
  String idProcessoSeletivo;

  String codigo;

  String descricao;

  String dataInicio;

  String dataTermino;

  String idProcessoSeletivoStatus;

  String processoSeletivoStatus;

  int diasEmAberto;

  String nomeCargo;

  String tipoContrato;

  String idCargo;

  int qtdeMinimoParticipantes;

  int qtdeMaximoParticipantes;

  int qtdeMaximoParticipantesAprovados;

  String idTipoContrato;

  String sexo;

  String caracteristicaCandidato;

  String responsavelRH;

  String localidade;

  String salarioFixoOuFaixa;

  double salarioValorFixo;

  double salarioValorFaixaInicial;

  double salarioValorFaixaFinal;

  bool salarioVisivel;

  String periodicidadePagamento;

  String escala;

  String tipoHorarioJornada;

  String horaEntradaJornada;

  String horaSaidaJornada;

  String cargaHorariaIntervalo;

  String beneficios;

  String outrasRemuneracoes;

  String progressoEtapa;

  int qtdeParticipantesTotal;

  int qtdeParticipantesAtual;

  ProcessoSeletivoViewModel(
      {this.idProcessoSeletivo,
      this.codigo,
      this.descricao,
      this.dataInicio,
      this.dataTermino,
      this.idProcessoSeletivoStatus,
      this.processoSeletivoStatus,
      this.diasEmAberto,
      this.nomeCargo,
      this.tipoContrato,
      this.idCargo,
      this.qtdeMinimoParticipantes,
      this.qtdeMaximoParticipantes,
      this.qtdeMaximoParticipantesAprovados,
      this.idTipoContrato,
      this.sexo,
      this.caracteristicaCandidato,
      this.responsavelRH,
      this.localidade,
      this.salarioFixoOuFaixa,
      this.salarioValorFixo,
      this.salarioValorFaixaInicial,
      this.salarioValorFaixaFinal,
      this.salarioVisivel,
      this.periodicidadePagamento,
      this.escala,
      this.tipoHorarioJornada,
      this.horaEntradaJornada,
      this.horaSaidaJornada,
      this.cargaHorariaIntervalo,
      this.beneficios,
      this.outrasRemuneracoes,
      this.progressoEtapa,
      this.qtdeParticipantesAtual,
      this.qtdeParticipantesTotal});

  factory ProcessoSeletivoViewModel.fromJson(Map<String, dynamic> json) {
    return new ProcessoSeletivoViewModel(
      idProcessoSeletivo: json['idProcessoSeletivo'],
      codigo: json['codigo'],
      descricao: json['descricao'],
      dataInicio: json['dataInicio'],
      dataTermino: json['dataTermino'],
      idProcessoSeletivoStatus: json['idProcessoSeletivoStatus'],
      processoSeletivoStatus: json['processoSeletivoStatus'],
      diasEmAberto: json['diasEmAberto'],
      nomeCargo: json['nomeCargo'],
      tipoContrato: json['tipoContrato'],
      idCargo: json['idCargo'],
      qtdeMinimoParticipantes: json['qtdeMinimoParticipantes'],
      qtdeMaximoParticipantes: json['qtdeMaximoParticipantes'],
      qtdeMaximoParticipantesAprovados:
          json['qtdeMaximoParticipantesAprovados'],
      idTipoContrato: json['idTipoContrato'],
      sexo: json['sexo'],
      caracteristicaCandidato: json['caracteristicaCandidato'],
      responsavelRH: json['responsavelRH'],
      localidade: json['localidade'],
      salarioFixoOuFaixa: json['salarioFixoOuFaixa'],
      salarioValorFixo: json['salarioValorFixo'],
      salarioValorFaixaInicial: json['salarioValorFaixaInicial'],
      salarioValorFaixaFinal: json['salarioValorFaixaFinal'],
      salarioVisivel: json['salarioVisivel'],
      periodicidadePagamento: json['periodicidadePagamento'],
      escala: json['escala'],
      tipoHorarioJornada: json['tipoHorarioJornada'],
      horaEntradaJornada: json['horaEntradaJornada'],
      horaSaidaJornada: json['horaSaidaJornada'],
      cargaHorariaIntervalo: json['cargaHorariaIntervalo'],
      beneficios: json['beneficios'],
      outrasRemuneracoes: json['outrasRemuneracoes'],
      progressoEtapa: json['progressoEtapa'],
      qtdeParticipantesAtual: json['qtdeParticipantesAtual'],
      qtdeParticipantesTotal: json['qtdeParticipantesTotal'],
    );
  }

  Map toMap() {
    return {
      "idProcessoSeletivo": this.idProcessoSeletivo,
      "codigo": this.codigo,
      "descricao": this.descricao,
      "dataInicio": this.dataInicio,
      "dataTermino": this.dataTermino,
      "idProcessoSeletivoStatus": this.idProcessoSeletivoStatus,
      "processoSeletivoStatus": this.processoSeletivoStatus,
      "diasEmAberto": this.diasEmAberto,
      "nomeCargo": this.nomeCargo,
      "tipoContrato": this.tipoContrato,
      "idCargo": this.idCargo,
      "qtdeMinimoParticipantes": this.qtdeMinimoParticipantes,
      "qtdeMaximoParticipantes": this.qtdeMaximoParticipantes,
      "qtdeMaximoParticipantesAprovados": this.qtdeMaximoParticipantesAprovados,
      "idTipoContrato": this.idTipoContrato,
      "sexo": this.sexo,
      "caracteristicaCandidato": this.caracteristicaCandidato,
      "responsavelRH": this.responsavelRH,
      "localidade": this.localidade,
      "salarioFixoOuFaixa": this.salarioFixoOuFaixa,
      "salarioValorFixo": this.salarioValorFixo,
      "salarioValorFaixaInicial": this.salarioValorFaixaInicial,
      "salarioValorFaixaFinal": this.salarioValorFaixaFinal,
      "salarioVisivel": this.salarioVisivel,
      "periodicidadePagamento": this.periodicidadePagamento,
      "escala": this.escala,
      "tipoHorarioJornada": this.tipoHorarioJornada,
      "horaEntradaJornada": this.horaEntradaJornada,
      "horaSaidaJornada": this.horaSaidaJornada,
      "cargaHorariaIntervalo": this.cargaHorariaIntervalo,
      "beneficios": this.beneficios,
      "outrasRemuneracoes": this.outrasRemuneracoes,
      "progressoEtapa": this.progressoEtapa,
      "qtdeParticipantesAtual": this.qtdeParticipantesAtual,
      "qtdeParticipantesTotal": this.qtdeParticipantesTotal,
    };
  }
}

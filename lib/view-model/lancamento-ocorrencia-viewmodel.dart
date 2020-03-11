class ZLancamentoOcorrenciaViewModel {
  String idLancamento;
  String idOcorrencia;
  String nomeOcorrencia;
  String nomeJustificativa;
  String detalheJustificativa;
  String abreviacao;
  String dataOcorrencia;
  bool automatica;

  ZLancamentoOcorrenciaViewModel(
      {this.idLancamento: "",
      this.idOcorrencia: "",
      this.nomeOcorrencia: "",
      this.nomeJustificativa: "",
      this.detalheJustificativa: "",
      this.abreviacao: "",
      this.dataOcorrencia: "",
      this.automatica: false,
    });
}

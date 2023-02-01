class HistoricoViewModel {
  String? caminhoAmbiente;
  String? caminhoTipoEquipamento;
  String? caminhoTipoProblema;
  String? dataAbertura;
  String? idSolicitacao;
  String? status;

  HistoricoViewModel(
      {this.idSolicitacao,
      this.caminhoAmbiente,
      this.caminhoTipoEquipamento,
      this.caminhoTipoProblema,
      this.dataAbertura,
      this.status});
}

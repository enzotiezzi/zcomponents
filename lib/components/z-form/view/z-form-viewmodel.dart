class ZFormViewModel {
  String idCampo;
  String idModelo;

  String nomeCampo;

  String tipoValorCampo;

  String tamanhoValorCampo;

  String tamanhoPrecisaoValorCampo;

  bool obrigatorio;

  String resposta;

  int maxLength;

  bool enabled;

  ZFormViewModel(
      {this.idModelo,
      this.idCampo,
      this.nomeCampo,
      this.obrigatorio,
      this.tamanhoPrecisaoValorCampo,
      this.tamanhoValorCampo,
      this.tipoValorCampo,
      this.resposta,
      this.maxLength,
      this.enabled=true});
}

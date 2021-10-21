class DialogPesquisaOrgazinacionalViewModel {
  String titulo;
  String descricaoCentral;
  String textoBotaoConfirmar;
  String textoBotaoCancelar;
  Function onTapBotaoConfirmar;
  Function onTapBotaoCancelar;

  DialogPesquisaOrgazinacionalViewModel(
      {this.titulo,
      this.descricaoCentral,
      this.textoBotaoConfirmar,
      this.textoBotaoCancelar,
      this.onTapBotaoConfirmar,
      this.onTapBotaoCancelar});
}

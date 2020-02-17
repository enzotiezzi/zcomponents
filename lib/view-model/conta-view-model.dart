class ContaViewModel {
  String idConta;
  String conta;
  bool ativa;

  ContaViewModel({this.idConta, this.conta, this.ativa});

  factory ContaViewModel.fromJson(Map<String, dynamic> json) {
    return new ContaViewModel(
        idConta: json["idConta"], conta: json["conta"], ativa: json["ativa"]);
  }
}

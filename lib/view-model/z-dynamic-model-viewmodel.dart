class ZDynamicModelViewModel {
  String idModelo;
  String nome;
  bool isAtivo;

  ZDynamicModelViewModel({
    this.idModelo,
    this.nome,
    this.isAtivo,
  });

  factory ZDynamicModelViewModel.fromJson(Map<String, dynamic> json) {
    return new ZDynamicModelViewModel(
      idModelo: json['idModelo'],
      nome: json['nome'],
      isAtivo: json['isAtivo'],
    );
  }

  Map toMap() {
    return {
      "idModelo": this.idModelo,
      "nome": this.nome,
      "isAtivo": this.isAtivo,
    };
  }
}

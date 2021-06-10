class PerfilViewModel {
  String idPerfil;
  String nome;
  String idApp;

  PerfilViewModel({
    this.idPerfil,
    this.nome,
    this.idApp,
  });

  static PerfilViewModel fromJson(Map<String, dynamic> json) {
    return new PerfilViewModel(
      idPerfil: json["idPerfil"],
      nome: json["nome"],
      idApp: json["idApp"],
    );
  }
}

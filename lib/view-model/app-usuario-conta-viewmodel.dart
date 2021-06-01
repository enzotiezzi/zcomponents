class AppUsuarioContaViewModel {
  String idApp;
  String nomeApp;
  String idUsuario;
  String nomeUsuario;
  String email;
  String telefone;
  String idConta;
  String nomeConta;
  String status;
  String dataVinculo;
  String dataExpiracao;
  String idPerfil;
  String nomePerfil;
  String descricaoPerfil;
  String tipoConta;
  bool alteraTotem;

  AppUsuarioContaViewModel({
    this.idApp,
    this.nomeApp,
    this.idUsuario,
    this.nomeUsuario,
    this.email,
    this.telefone,
    this.idConta,
    this.nomeConta,
    this.status,
    this.dataVinculo,
    this.dataExpiracao,
    this.idPerfil,
    this.nomePerfil,
    this.descricaoPerfil,
    this.tipoConta,
    this.alteraTotem,
  });

  factory AppUsuarioContaViewModel.fromJson(Map<String, dynamic> json) {
    return new AppUsuarioContaViewModel(
      idApp: json["idApp"],
      nomeApp: json["nomeApp"],
      idUsuario: json["idUsuario"],
      nomeUsuario: json["nomeUsuario"],
      email: json["email"],
      telefone: json["telefone"],
      idConta: json["idConta"],
      nomeConta: json["nomeConta"],
      status: json["status"],
      dataVinculo: json["dataVinculo"],
      dataExpiracao: json["dataExpiracao"],
    );
  }

  Map toMap(){
    return {
      "idApp": this.idApp,
      "nomeApp": this.nomeApp,
      "idUsuario":this.idUsuario,
      "email": this.email,
      "telefone":this.telefone,
      "idConta": this.idConta,
      "nomeConta":this.nomeConta,
      "status":this.status,
      "dataVinculo":this.dataVinculo,
      "dataExpiracao":this.dataExpiracao,
      "idPerfil":this.idPerfil,
      "nomePerfil": this.nomePerfil,
      "descricaoPerfil": this.descricaoPerfil,
      "tipoConta":this.tipoConta
    };
  }
}

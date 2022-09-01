class ContratacaoStatus {
  String idContratacaoStatus;
  String nome;

  ContratacaoStatus({this.idContratacaoStatus, this.nome: ""});

  static ContratacaoStatus fromJson(Map<String, dynamic> json) {
    return new ContratacaoStatus(
        nome: json["nome"],
        idContratacaoStatus: json["idContratacaoStatus"]);
  }

  Map toMap() {
    return {
      "nome": this.nome,
      "idContratacaoStatus": this.idContratacaoStatus,
    };
  }
}

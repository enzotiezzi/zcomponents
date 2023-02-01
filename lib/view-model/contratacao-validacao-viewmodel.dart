class ContratacaoValidacaoStatusViewModel {
  String? idContratacaoValidacaoStatus;
  String? nome;

  ContratacaoValidacaoStatusViewModel(
      {this.idContratacaoValidacaoStatus, this.nome});

  static ContratacaoValidacaoStatusViewModel fromJson(
      Map<String, dynamic> json) {
    return new ContratacaoValidacaoStatusViewModel(
        idContratacaoValidacaoStatus: json["idContratacaoValidacaoStatus"],
        nome: json["nome"]);
  }

  Map toMap (){
    return{
      "idContratacaoValidacaoStatus":this.idContratacaoValidacaoStatus,
      "nome": this.nome
    };
  }
}

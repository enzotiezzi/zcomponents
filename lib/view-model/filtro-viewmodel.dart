import 'dart:convert';

class FiltroViewModel {
  List<String> idsEmpresa;
  List<String> idsResponsavel;
  List<String> idsCentroCusto;
  List<String> ordem;
  String nome;
  String data;

  FiltroViewModel(
      {this.idsEmpresa,
      this.idsResponsavel,
      this.idsCentroCusto,
      this.nome,
      this.data,
      this.ordem});

  Map toMap() {
    return {
      "idsEmpresa": json.encode(this.idsEmpresa),
      "idsResponsavel": json.encode(this.idsResponsavel),
      "idsCentroCusto": json.encode(this.idsCentroCusto),
      "ordem": this.ordem,
      "nome": this.nome,
      "data": this.data,
    };
  }
}

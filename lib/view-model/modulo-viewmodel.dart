
class ModuloViewModel {
  String idModulo;
  String nome;

  ModuloViewModel({this.idModulo,this.nome});

  static ModuloViewModel fromJson(Map<String,dynamic> json){
    return new ModuloViewModel(
      idModulo: json["idModulo"],
      nome: json["nome"]
    );
  }

  Map toMap(){
    return
      {
        "idModulo": this.idModulo,
        "nome":this.nome
      };
  }
}
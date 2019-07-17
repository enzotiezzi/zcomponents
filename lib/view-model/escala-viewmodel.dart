class EscalaViewModel {
  String idEscala;
  String status;
  String nome;
  String padraodPS;
  String escala;

  EscalaViewModel({
    this.idEscala: "",
    this.status: "",
    this.nome: "",
    this.padraodPS: "",
    this.escala: ""
  });

  factory EscalaViewModel.fromJson(Map<String, dynamic> json) {
    return new EscalaViewModel(
        idEscala: json['idEscala'],
        status: json['status'],
        nome: json['nome'],
        padraodPS: json['padraodPS'],
        escala: json["escala"]
    );
  }

  Map toMap() {
    return {
      "idEscala": this.idEscala,
      "status": this.status,
      "nome": this.nome,
      "padraodPS": this.padraodPS,
      "escala": this.escala,
    };
  }
}
class CargoViewModel {
  String idCargo;
  String industria;
  String nome;
  String nivelCargo;
  String cBO;

  CargoViewModel(
      {this.idCargo: "",
      this.industria: "",
      this.nome: "",
      this.nivelCargo: "",
      this.cBO: ""});

  factory CargoViewModel.fromJson(Map<String, dynamic> json) {
    return new CargoViewModel(
        idCargo: json['idCargo'],
        industria: json['industria'],
        nome: json['nome'],
        nivelCargo: json['nivelCargo'],
        cBO: json["cBO"]);
  }

  Map toMap() {
    return {
      "idCargo": this.idCargo,
      "industria": this.industria,
      "nome": this.nome,
      "nivelCargo": this.nivelCargo,
      "cBO": this.cBO,
    };
  }
}

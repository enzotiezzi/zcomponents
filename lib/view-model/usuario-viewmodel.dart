class UsuarioViewModel {
  String nome;
  String rE;
  String celular;
  String email;
  String endereco;

  UsuarioViewModel({
    this.nome: "",
    this.rE: "",
    this.celular: "",
    this.email: "",
    this.endereco: "",
  });

  Map toMap() {
    return {
      "nome": this.nome,
      "rE": this.rE,
      "celular": this.celular,
      "email": this.email,
      "endereco": this.endereco,
    };
  }

  factory UsuarioViewModel.fromJson(Map<String, dynamic> json) {
    return new UsuarioViewModel(
      nome: json['nome'],
      rE: json['rE'],
      celular: json['celular'],
      email: json['email'],
      endereco: json['endereco'],
    );
  }
}

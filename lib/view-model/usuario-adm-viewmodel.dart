class UsuarioAdmViewModel {
  String nome;
  String idUsuario;
  String telefone;
  String email;
  String userName;

  UsuarioAdmViewModel({
    this.nome: "",
    this.idUsuario: "",
    this.telefone: "",
    this.email: "",
    this.userName: "",
  });

  Map toMap() {
    return {
      "nome": this.nome,
      "idUsuario": this.idUsuario,
      "telefone": this.telefone,
      "email": this.email,
      "userName": this.userName,
    };
  }

  factory UsuarioAdmViewModel.fromJson(Map<String, dynamic> json) {
    return new UsuarioAdmViewModel(
      nome: json['nome'],
      idUsuario: json['idUsuario'],
      telefone: json['telefone'],
      email: json['email'],
      userName: json['userName'],
    );
  }
}

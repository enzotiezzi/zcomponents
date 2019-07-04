class ZCadastroTeste {
  String nome;
  String cpf;
  String celular;
  String email;
  String dataNascimento;
  String senha;
  String repetirSenha;

  ZCadastroTeste(
      {this.senha: "",
      this.repetirSenha: "",
      this.email: "",
      this.dataNascimento: "",
      this.celular: "",
      this.cpf: "",
      this.nome: ""});

  bool validate(
      nome, cpf, celular, email, dataNascimento, senha, repetirSenha) {
    if (nome == "") {
      print("erro nome");
      return false;
    }
    if (cpf == "") {
      print("erro cpf");

      return false;
    }
    if (celular == "") {
      print("erro celular");

      return false;
    }
    if (email == "") {
      print("erro email");

      return false;
    }
    if (dataNascimento == "") {
      print("erro nascimento");

      return false;
    }
    if (senha == "") {
      print("erro senha");

      return false;
    }
    if (repetirSenha == "") {
      print("erro repetir senha");

      return false;
    }
    return true;
  }
}

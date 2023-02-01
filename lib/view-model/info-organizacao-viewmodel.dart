class InfoOrganizacaoViewModel {
  String? idConta;
  String? nome;
  String? nomeFantasia;
  String? cpfOuCNPJ;
  String? tipoPessoa;
  String? dataCriacao;
  String? logradouro;
  String? cep;
  String? numero;
  String? bairro;
  String? complemento;
  String? cidade;
  String? estado;
  String? telefone;
  String? email;
  bool? ativo;
  String? codigoAtivacao;
  String? corPrimaria;
  String? corSecundaria;
  String? context;

  InfoOrganizacaoViewModel(
      {this.idConta,
      this.nome,
      this.nomeFantasia,
      this.cpfOuCNPJ,
      this.tipoPessoa,
      this.dataCriacao,
      this.logradouro,
      this.cep,
      this.numero,
      this.bairro,
      this.complemento,
      this.cidade,
      this.estado,
      this.telefone,
      this.email,
      this.ativo,
      this.codigoAtivacao,
      this.corPrimaria,
      this.corSecundaria,
      this.context});

  static InfoOrganizacaoViewModel fromJson(Map<String, dynamic> json) {
    return new InfoOrganizacaoViewModel(
        idConta: json['idConta'],
        nome: json['nome'],
        nomeFantasia: json['nomeFantasia'],
        cpfOuCNPJ: json['cpfOuCNPJ'],
        tipoPessoa: json['tipoPessoa'],
        dataCriacao: json['dataCriacao'],
        logradouro: json['logradouro'],
        cep: json['cep'],
        numero: json['numero'],
        bairro: json['bairro'],
        complemento: json['complemento'],
        cidade: json['cidade'],
        estado: json['estado'],
        telefone: json['telefone'],
        email: json['email'],
        ativo: json['ativo'],
        codigoAtivacao: json['codigoAtivacao'],
        corPrimaria: json['corPrimaria'],
        corSecundaria: json['corSecundaria'],
        context: json["context"]);
  }

  Map toMap() {
    return {
      "idConta": this.idConta,
      "nome": this.nome,
      "nomeFantasia": this.nomeFantasia,
      "cpfOuCNPJ": this.cpfOuCNPJ,
      "tipoPessoa": this.tipoPessoa,
      "dataCriacao": this.dataCriacao,
      "logradouro": this.logradouro,
      "cep": this.cep,
      "numero": this.numero,
      "bairro": this.bairro,
      "complemento": this.complemento,
      "cidade": this.cidade,
      "estado": this.estado,
      "telefone": this.telefone,
      "email": this.email,
      "ativo": this.ativo,
      "codigoAtivacao": this.codigoAtivacao,
      "corPrimaria": this.corPrimaria,
      "corSecundaria": this.corSecundaria,
      "context": this.context
    };
  }
}

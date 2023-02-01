class CompanyViewModel {
  String? idEmpresa;
  String? nome;
  String? codigo;
  String? endereco;
  String? bairro;
  String? cidade;
  String? estado;
  String? cep;
  String? complemento;
  String? numero;
  String? cnpj;
  String? cPFOuCNPJ;
  String? razaoSocial;
  String? telefone;
  String? userId;
  String? contexto;
  String? latitude;
  String? longitude;

  CompanyViewModel(
      {this.idEmpresa: "",
      this.nome: "",
      this.codigo: "",
      this.endereco: "",
      this.bairro: "",
      this.cidade: "",
      this.estado: "",
      this.cep: "",
      this.complemento: "",
      this.numero,
      this.cnpj: "",
      this.razaoSocial: "",
      this.telefone: "",
      this.userId,
      this.cPFOuCNPJ,
      this.contexto,
      this.latitude,
      this.longitude});

  Map toMap() {
    return {
      "idEmpresa": this.idEmpresa,
      "nome": this.nome,
      "codigo": this.codigo,
      "endereco": this.endereco,
      "bairro": this.bairro,
      "cidade": this.cidade,
      "estado": this.estado,
      "cep": this.cep,
      "complemento": this.complemento,
      "numero": this.numero,
      "cpfOucnpj": this.cPFOuCNPJ,
      "razaoSocial": this.razaoSocial,
      "telefone": this.telefone,
      "userId": this.userId,
      "contexto": this.contexto,
      "latitude": this.latitude,
      "longitude": this.longitude
    };
  }

  factory CompanyViewModel.fromJson(Map<String, dynamic> json) {
    return new CompanyViewModel(
        idEmpresa: json['idEmpresa'],
        nome: json['nome'],
        codigo: json['codigo'],
        endereco: json['endereco'],
        bairro: json['bairro'],
        cidade: json['cidade'],
        estado: json['estado'],
        cep: json['cep'],
        complemento: json['complemento'],
        numero: json['numero'].toString(),
        cnpj: json['cnpj'],
        razaoSocial: json['razaoSocial'],
        telefone: json['telefone'],
        userId: json["userId"],
        cPFOuCNPJ: json["cpfOucnpj"],
        contexto: json["contexto"],
        latitude: json["latitude"],
        longitude: json["longitude"]);
  }
}

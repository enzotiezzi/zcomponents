class EnderecoViewModel{
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;

  EnderecoViewModel({this.cep, this.logradouro, this.complemento, this.bairro, this.localidade, this.uf});

  factory EnderecoViewModel.fromJson(Map<String, dynamic> json){
    return new EnderecoViewModel(
      cep: json["cep"],
      logradouro: json["logradouro"],
      complemento: json["complemento"],
      bairro: json["bairro"],
      localidade: json["localidade"],
      uf: json["uf"]
    );
  }
}
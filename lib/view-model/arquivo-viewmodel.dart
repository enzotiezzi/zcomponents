class ArquivoViewModel {
  String? nome;
  double? tamanho;
  String? descricao;
  String? contentType;
  String? container;
  String? conteudo;
  String? id;

  ArquivoViewModel(
      {this.nome,
      this.tamanho,
      this.descricao,
      this.contentType,
      this.container,
      this.conteudo,
      this.id});

  factory ArquivoViewModel.fromJson(Map<String, dynamic> json) {
    return new ArquivoViewModel(
        nome: json['nome'],
        tamanho: json['tamanho'],
        descricao: json['descricao'],
        contentType: json['contentType'],
        container: json['container'],
        conteudo: json['conteudo'],
        id: json['id']);
  }

  Map toMap() {
    return {
      "nome": this.nome,
      "tamanho": this.tamanho,
      "descricao": this.descricao,
      "contentType": this.contentType,
      "container": this.container,
      "conteudo": this.conteudo,
      "id": this.id
    };
  }
}

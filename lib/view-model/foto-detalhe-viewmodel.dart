import 'dart:typed_data';

class FotoDetalheViewModel {
  String? id;
  String? idConta;
  String? nome;
  int? tamanho;
  String? descricao;
  String? contentType;
  String? idUsuario;
  String? container;
  String? conteudo;
  bool? fotoSincronizada;

  FotoDetalheViewModel({
    this.id,
    this.idConta,
    this.nome,
    this.tamanho,
    this.descricao,
    this.contentType,
    this.idUsuario,
    this.container,
    this.conteudo,
    this.fotoSincronizada = true,
  });

  factory FotoDetalheViewModel.fromJson(Map<String, dynamic> json) {
    return new FotoDetalheViewModel(
      id: json['id'],
      idConta: json['idConta'],
      nome: json['nome'],
      tamanho: json['tamanho'],
      descricao: json['descricao'],
      contentType: json['contentType'],
      idUsuario: json['idUsuario'],
      container: json['container'],
      conteudo: json['conteudo'],
    );
  }

  Map toMap() {
    return {
      "id": this.id,
      "idConta": this.idConta,
      "nome": this.nome,
      "tamanho": this.tamanho,
      "descricao": this.descricao,
      "contentType": this.contentType,
      "idUsuario": this.idUsuario,
      "container": this.container,
      "conteudo": this.conteudo,
    };
  }
}

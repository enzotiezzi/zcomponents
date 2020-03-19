class NoticiaViewModel {
  String idNoticia;
  String idCategoria;
  String autor;
  String titulo;
  String descricao;
  String url;
  String urlImagem;
  String publicadaEm;

  NoticiaViewModel({
    this.idNoticia,
    this.idCategoria,
    this.autor,
    this.titulo,
    this.descricao,
    this.url,
    this.urlImagem,
    this.publicadaEm,
  });

  factory NoticiaViewModel.fromJson(Map<String, dynamic> json) {
    return new NoticiaViewModel(
      idNoticia: json['idNoticia'],
      idCategoria: json['idCategoria'],
      autor: json['autor'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      url: json['url'],
      urlImagem: json['urlImagem'],
      publicadaEm: json['publicadaEm'],
    );
  }

  Map toMap() {
    return {
      "idNoticia": this.idNoticia,
      "idCategoria": this.idCategoria,
      "autor": this.autor,
      "titulo": this.titulo,
      "descricao": this.descricao,
      "url": this.url,
      "urlImagem": this.urlImagem,
      "publicadaEm": this.publicadaEm,
    };
  }
}

import 'dart:typed_data';
import 'documento-campo.dart';

class ColaboradorDocumentoViewModel {
  String idColaborador;
  String idDocumento;
  String nomeDocumento;
  String status;
  String idImagemDocumento;
  Uint8List imagemDocumento;
  String horizontalOuVertical;
  String qtdePaginaUpload;
  bool imagemObrigatoria;
  bool documentoAtualizado;
  List<dynamic> campos;

  ColaboradorDocumentoViewModel(
      {this.idColaborador: "",
      this.idDocumento: "",
      this.nomeDocumento: "",
      this.status: "",
      this.idImagemDocumento: "",
      this.imagemDocumento,
      this.campos,
      this.horizontalOuVertical,
      this.imagemObrigatoria,
      this.qtdePaginaUpload,
      this.documentoAtualizado=false});

  factory ColaboradorDocumentoViewModel.fromJson(Map<String, dynamic> json) {
    return new ColaboradorDocumentoViewModel(
        idColaborador: json['idColaborador'],
        idDocumento: json['idDocumento'],
        nomeDocumento: json['nomeDocumento'],
        status: json['status'],
        idImagemDocumento: json['idImagemDocumento'],
        imagemDocumento: json['imagemDocumento'],
        horizontalOuVertical: json['horizontalOuVertical'],
        qtdePaginaUpload: json['qtdePaginaUpload'],
        imagemObrigatoria: json['imagemObrigatoria'],
        documentoAtualizado: json["documentoAtualizado"],
        campos: (json['campos'] != null)
            ? (json['campos']).map((x) => DocumentoCampo.fromJson(x)).toList()
            : new List());
  }

  Map toMap() {
    return {
      "idColaborador": this.idColaborador,
      "idDocumento": this.idDocumento,
      "nomeDocumento": this.nomeDocumento,
      "status": this.status,
      "idImagemDocumento": this.idImagemDocumento,
      "imagemDocumento": this.imagemDocumento,
      "imagemObrigatoria": this.imagemObrigatoria,
      "documentoAtualizado": this.documentoAtualizado
    };
  }
}

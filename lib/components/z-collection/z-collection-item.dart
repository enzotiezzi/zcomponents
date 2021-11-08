import 'package:meta/meta.dart';

class ZCollectionItem {
  final String chave;
  final String chaveSecundaria;
  String valor;
  final String titulo;
  final String ordem;

  ZCollectionItem(
      {@required this.chave,
      @required this.titulo,
      @required this.valor,
      this.chaveSecundaria,
      this.ordem = ""});
}

import 'package:meta/meta.dart';

class ZCollectionItem {
  final String chave;
  final String chaveSecundaria;
  String valor;
  final String titulo;

  ZCollectionItem(
      {@required this.chave,
      @required this.titulo,
      @required this.valor,
      this.chaveSecundaria});
}

import 'package:meta/meta.dart';

class ZSelectionItem {
  final String chave;
  final String chaveSecundaria;
  String valor;
  final String titulo;
  bool selecionado;

  ZSelectionItem(
      {@required this.chave,
      @required this.titulo,
      @required this.valor,
      this.chaveSecundaria,
      this.selecionado: false});
}

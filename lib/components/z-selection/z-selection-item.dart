import 'package:meta/meta.dart';

class ZSelectionItem {
  final String? chave;
  final String? chaveSecundaria;
  String? valor;
  final String? titulo;
  bool? selecionado;
  bool? obrigatorio;

  ZSelectionItem(
      {@required this.chave,
      @required this.titulo,
      @required this.valor,
      this.chaveSecundaria,
      this.selecionado: false,
      this.obrigatorio: false});
}

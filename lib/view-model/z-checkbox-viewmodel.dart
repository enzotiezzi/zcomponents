import 'package:flutter/material.dart';

class ZCheckBoxViewModel {
  String descricao;
  String value;
  bool foiMarcado;

  ZCheckBoxViewModel({@required this.descricao, @required this.value,this.foiMarcado: false});
}

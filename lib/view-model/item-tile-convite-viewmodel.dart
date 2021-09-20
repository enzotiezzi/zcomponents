import 'package:flutter/cupertino.dart';


class ItemTileViewModel {
  String nome;
  String dataAdmissao;
  String cargo;
  String porcentagemPreenchimento;
  String status;
  String prazo;
  Function onTileIsSelected;
  Widget icone;

  ItemTileViewModel({
    this.nome,
    this.dataAdmissao,
    this.cargo,
    this.porcentagemPreenchimento,
    this.prazo,
    this.onTileIsSelected,
    this.status,
    this.icone,
  });
}

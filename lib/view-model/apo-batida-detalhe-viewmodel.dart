import 'dart:typed_data';
import 'package:z_components/infra/db/database-utils.dart';
import 'package:z_components/infra/entities/z-entity.dart';
import 'package:z_components/infra/schema/z-column.dart';
import 'package:z_components/infra/schema/z-table.dart';

class APOBatidaDetalheViewModel {
  String idBatida;
  String appBatida;
  String versaoAppBatida;
  String sistemaAppBatida;
  String conexao;
  String idDispositivo;
  String endereco;

  APOBatidaDetalheViewModel(
      {this.idBatida,
      this.appBatida,
      this.versaoAppBatida,
      this.sistemaAppBatida,
      this.conexao,
      this.idDispositivo,
      this.endereco,
      int id,
      String idConta});
}

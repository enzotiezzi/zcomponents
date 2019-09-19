import 'package:z_components/infra/db/database-utils.dart';
import 'package:z_components/infra/entities/z-entity.dart';
import 'package:z_components/infra/schema/z-column.dart';
import 'package:z_components/infra/schema/z-table.dart';

class Monstro extends ZEntity {
  String nome;
  String habilidade;

  Monstro({this.nome, this.habilidade, int id, String idConta})
      : super(id: id, idConta: idConta);

  @override
  void buildTable() {
    setTableName();
    table = new ZTable(version: 2, columns: [
      new ZColumn(
          version: 2,
          name: "ID",
          type: DatabaseUtils.INTEGER,
          primaryKey: true,
          autoIncrement: true,
          notNull: true),
      new ZColumn(version: 2, name: "NOME", type: DatabaseUtils.TEXT),
      new ZColumn(version: 2, name: "HABILIDADE", type: DatabaseUtils.TEXT),
    ]);
  }

  @override
  ZEntity fromMap(Map<String, dynamic> map) {
    this.id = map["ID"];
    this.nome = map["NOME"];
    this.habilidade = map["HABILIDADE"];

    return this;
  }

  @override
  void setTableName() {
    tableName = "MONSTRO";
  }

  @override
  Map<String, dynamic> toMap() {
    return {"ID": this.id, "NOME": this.nome, "HABILIDADE": this.habilidade};
  }
}

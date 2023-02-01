import 'package:z_components/infra/entities/z-entity.dart';
import 'package:z_components/infra/db/database-utils.dart';
import 'package:z_components/infra/schema/z-column.dart';
import 'package:z_components/infra/schema/z-table.dart';

class Pessoa extends ZEntity {
  String? nome;
  int? idade;

  Pessoa({this.nome, this.idade, int? id, String? idConta})
      : super(id: id, idConta: idConta);

  @override
  Map<String, dynamic> toMap() {
    return {"ID": this.id, "NOME": this.nome, "IDADE": this.idade};
  }

  @override
  void buildTable() {
    setTableName();
    this.table = new ZTable(version: 1, columns: [
      new ZColumn(
          version: 1,
          name: "ID",
          type: DatabaseUtils.INTEGER,
          primaryKey: true,
          autoIncrement: true,
          notNull: true),
      new ZColumn(version: 1, name: "NOME", type: DatabaseUtils.TEXT),
      new ZColumn(version: 1, name: "IDADE", type: DatabaseUtils.INTEGER)
    ]);
  }

  @override
  void setTableName() {
    tableName = "PESSOA";
  }

  @override
  ZEntity fromMap(Map<String, dynamic> map) {
    this.id = map["ID"];
    this.nome = map["NOME"];
    this.idade = map["IDADE"];

    return this;
  }
}

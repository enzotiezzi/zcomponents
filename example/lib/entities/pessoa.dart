import 'package:z_components/infra/entities/z-entity.dart';
import 'package:z_components/infra/db/database-utils.dart';

class Pessoa extends ZEntity {
  String nome;
  int idade;

  Pessoa({this.nome, this.idade});

  @override
  Map<String, dynamic> toMap() {
    return {
      "ID": this.id,
      "NOME": this.nome,
      "IDADE": this.idade
    };
  }

  @override
  void buildTable() {
    setTableName();
    this.table = {
      DatabaseUtils.COLUMNS: [
        {
          DatabaseUtils.VERSION: 1,
          DatabaseUtils.COLUMN_NAME: "ID",
          DatabaseUtils.COLUMN_TYPE: DatabaseUtils.INTEGER,
          DatabaseUtils.PRIMARY_KEY: true,
          DatabaseUtils.AUTO_INCREMENT: true,
          DatabaseUtils.NOT_NULL: true
        },
        {
          DatabaseUtils.VERSION: 1,
          DatabaseUtils.COLUMN_NAME: "NOME",
          DatabaseUtils.COLUMN_TYPE: DatabaseUtils.TEXT
        },
        {
          DatabaseUtils.VERSION: 1,
          DatabaseUtils.COLUMN_NAME: "IDADE",
          DatabaseUtils.COLUMN_TYPE: DatabaseUtils.INTEGER
        }
      ]
    };
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

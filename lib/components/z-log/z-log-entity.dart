import 'package:z_components/infra/db/database-utils.dart';
import 'package:z_components/infra/entities/z-entity.dart';
import 'package:z_components/infra/schema/z-column.dart';
import 'package:z_components/infra/schema/z-table.dart';

class ZLogEntity extends ZEntity {
  String user;
  String errorMessage;
  String when;
  String app;
  String payload;
  String method;
  bool sync;

  ZLogEntity(
      {this.user,
      this.errorMessage,
      this.when,
      this.app,
      this.payload,
      this.method,
      this.sync});

  @override
  void buildTable() {
    this.table = new ZTable(version: 1, columns: [
      new ZColumn(
          version: 1,
          primaryKey: true,
          notNull: true,
          name: "ID",
          autoIncrement: true,
          type: DatabaseUtils.INTEGER),
      new ZColumn(version: 1, name: "IDCONTA", type: DatabaseUtils.TEXT),
      new ZColumn(version: 1, name: "USER", type: DatabaseUtils.TEXT),
      new ZColumn(version: 1, name: "ERRORMESSAGE", type: DatabaseUtils.TEXT),
      new ZColumn(version: 1, name: "WHEN", type: DatabaseUtils.TEXT),
      new ZColumn(version: 1, name: "APP", type: DatabaseUtils.TEXT),
      new ZColumn(version: 1, name: "PAYLOAD", type: DatabaseUtils.TEXT),
      new ZColumn(version: 1, name: "METHOD", type: DatabaseUtils.TEXT),
      new ZColumn(version: 1, name: "SYNC", type: DatabaseUtils.INTEGER)
    ]);
  }

  @override
  ZEntity fromMap(Map<String, dynamic> map) {
    this.user = map["USER"];
    this.errorMessage = map["ERRORMESSAGE"];
    this.when = map["WHEN"];
    this.app = map["APP"];
    this.payload = map["PAYLOAD"];
    this.method = map["METHOD"];
    this.sync = map["SYNC"] == 1;

    return this;
  }

  @override
  void setTableName() {
    this.tableName = "ZLOG";
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "USER": this.user,
      "ERRORMESSAGE": this.errorMessage,
      "WHEN": this.when,
      "APP": this.app,
      "PAYLOAD": this.payload,
      "METHOD": this.method
    };
  }
}

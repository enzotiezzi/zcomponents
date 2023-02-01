import 'package:sqflite/sqlite_api.dart';
import 'package:z_components/infra/schema/z-column.dart';
import 'package:z_components/infra/schema/z-table.dart';

abstract class ZEntity {
  int? id;
  String? idConta;

  String? tableName;

  ZTable? table;

  ZEntity({this.id, this.idConta});

  Map<String, dynamic> toMap();
  ZEntity fromMap(Map<String, dynamic> map);

  void buildTable();
  void setTableName();

  Future createTable(Database db) async {
    buildTable();

    try {
      await db.execute(_toSQL(table!));
    } catch (e) {}
  }

  Future alterTable(Database db, ZColumn column) async {
    buildTable();

    var command =
        "ALTER TABLE $tableName ADD COLUMN ${column.name} ${column.type}";

    if (column.primaryKey != null && column.primaryKey!)
      command += " PRIMARY KEY";
    if (column.autoIncrement != null && column.autoIncrement!)
      command += " AUTOINCREMENT";
    if (column.notNull != null && column.notNull!) command += " NOT NULL";

    try {
      await db.execute(command);
    } catch (e) {}
  }

  String _toSQL(ZTable table) {
    List<ZColumn> columns = table.columns!;

    String command =
        "CREATE TABLE IF NOT EXISTS $tableName (${_extractColumns(columns)})";

    return command;
  }

  String _extractColumns(List<ZColumn> columns) {
    var command = [];

    columns.forEach((c) {
      String? columnName = c.name;
      String? type = c.type;
      bool? primaryKey = c.primaryKey;
      bool? autoIncrement = c.autoIncrement;
      bool? notNull = c.notNull;

      var cmd = "$columnName $type";

      if (primaryKey != null && primaryKey) cmd += " PRIMARY KEY";
      if (autoIncrement != null && autoIncrement) cmd += " AUTOINCREMENT";
      if (notNull != null && notNull) cmd += " NOT NULL";

      command.add(cmd);
    });

    return command.join(", ");
  }
}

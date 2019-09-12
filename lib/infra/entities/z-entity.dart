import 'package:sqflite/sqlite_api.dart';
import 'package:z_components/infra/db/database-utils.dart';
import 'package:z_components/infra/interfaces/i-command.dart';

abstract class ZEntity{
  int id;
  String idConta;

  String tableName;

  Map<String, dynamic> table;

  Map<String, dynamic> toMap();
  ZEntity fromMap(Map<String, dynamic> map);

  void buildTable();
  void setTableName();

  void createTable(Database db) async{
    buildTable();
    await db.execute(_toSQL(table));
  }

  String _toSQL(Map<String, dynamic> table) {
    List<Map<String, dynamic>> columns = table[DatabaseUtils.COLUMNS];

    String command = "CREATE TABLE $tableName (${_extractColumns(columns)})";

    return command;
  }

  String _extractColumns(List<Map<String, dynamic>> columns) {
    var command = [];

    columns.forEach((c) {
      String columnName = c[DatabaseUtils.COLUMN_NAME];
      String type = c[DatabaseUtils.COLUMN_TYPE];
      bool primaryKey = c[DatabaseUtils.PRIMARY_KEY];
      bool autoIncrement = c[DatabaseUtils.AUTO_INCREMENT];
      bool notNull = c[DatabaseUtils.NOT_NULL];
      int version = c[DatabaseUtils.VERSION];

      var cmd = "$columnName $type";

      if(primaryKey != null && primaryKey) cmd += " PRIMARY KEY";
      if(autoIncrement != null && autoIncrement) cmd += " AUTOINCREMENT";
      if(notNull != null && notNull) cmd += " NOT NULL";

      command.add(cmd);
    });

    return command.join(", ");
  }
}

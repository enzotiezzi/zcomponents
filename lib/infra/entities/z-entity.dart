import 'package:sqflite/sqlite_api.dart';

abstract class ZEntity {
  int id;
  String idConta;

  Map<String, dynamic> structure;

  Map toMap();

  void createTable(Database db) async{
    await db.execute(_toSQL(structure));
  }

  String _toSQL(Map<String, dynamic> table) {
    String tableName = table['tableName'];

    List<Map<String, dynamic>> columns = table["columns"];

    String command = "CREATE TABLE $tableName (${_extractColumns(columns)})";

    return command;
  }

  String _extractColumns(List<Map<String, dynamic>> columns) {
    var command = [];

    columns.forEach((c) {
      String columnName = c["name"];
      String type = c["type"];
      bool primaryKey = c["primaryKey"];
      bool autoIncrement = c["autoIncrement"];
      bool notNull = c["notNull"];
      int version = c["version"];

      var cmd = "$columnName $type";

      if(primaryKey) cmd += " PRIMARY KEY";
      if(autoIncrement) cmd += "AUTOINCREMENT";
      if(notNull) cmd += "NOT NULL";

      command.add(cmd);
    });

    return command.join(",");
  }
}

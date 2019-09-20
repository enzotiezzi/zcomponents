import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:z_components/infra/entities/z-entity.dart';
import 'package:z_components/infra/interfaces/i-command.dart';
import 'package:z_components/infra/interfaces/i-context.dart';
import 'package:z_components/infra/interfaces/i-query.dart';
import 'package:injector/injector.dart';

class ZDatabase implements IContext{
  List<ZEntity> entidades;
  int version;
  String dbName;

  Database _db;

  ZDatabase(
      {@required this.entidades,
      @required this.dbName,
      @required this.version});

  Future init() async {
    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, dbName);

    _db = await openDatabase(path, version: this.version,
        onCreate: (db, version) {
      entidades.forEach((e) => e.createTable(db));
    });

    Injector.appInstance.clearAll();

    Injector.appInstance.registerDependency<IContext>((_) => this);
  }

  @override
  Future<int> delete(ZEntity entity) async{
    entity.setTableName();

    return await _db.delete(entity.tableName, where: "id=?", whereArgs: [entity.id]);
  }

  @override
  Future<int> insert(ZEntity entity) async{
    entity.setTableName();

    return await _db.insert(entity.tableName, entity.toMap());
  }

  @override
  Future<int> update(ZEntity entity) async{
    entity.setTableName();

    return await _db.update(entity.tableName, entity.toMap(), where: "id=?", whereArgs: [entity.id]);
  }

  @override
  Future<Map<String, dynamic>> queryFirstAsync(String query, {List arguments}) async{
    var res = await _db.rawQuery(query, arguments);

    return res.first;
  }

  @override
  Future<List<Map<String, dynamic>>> queryMultipleAsync(String query, {List arguments}) async{
    var res = await _db.rawQuery(query, arguments);

    return res.toList();
  }
}
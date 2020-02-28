import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:z_components/components/z-injector/z-injector.dart';
import 'package:z_components/infra/entities/z-entity.dart';
import 'package:z_components/infra/interfaces/i-context.dart';
import 'package:injector/injector.dart';

class ZDatabase implements IContext {
  List<ZEntity> entities;
  int version;
  String dbName;

  Database _db;

  ZDatabase(
      {@required this.entities, @required this.dbName, @required this.version});

  Future init() async {
    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, dbName);

    _db = await openDatabase(path, version: this.version,
        onCreate: (db, version) {
      entities.forEach((e) async => await e.createTable(db));
    }, onUpgrade: _onUpgrade);

    ZInjector.registerDependency<IContext>(this);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    for (int i = oldVersion + 1; i <= newVersion; i++) {
      // first create tables for the version
      var tables = entities.where((x) {
        x.buildTable();

        return x.table.version == i;
      }).toList();

      if (tables.length > 0) {
        tables.forEach((x) async => await x.createTable(db));
      }

      //then alter tables
      entities.forEach((x) {
        var newColumns = x.table.columns.where((y) => y.version == i);

        newColumns.forEach((y) async => await x.alterTable(db, y));
      });
    }
  }

  @override
  Future<int> delete(ZEntity entity) async {
    entity.setTableName();

    return await _db
        .delete(entity.tableName, where: "id=?", whereArgs: [entity.id]);
  }

  @override
  Future<int> deleteAll(ZEntity entity) async {
    entity.setTableName();

    return await _db.delete(entity.tableName);
  }

  @override
  Future<int> insert(ZEntity entity) async {
    entity.setTableName();

    return await _db.insert(entity.tableName, entity.toMap());
  }

  @override
  Future<int> update(ZEntity entity) async {
    entity.setTableName();

    return await _db.update(entity.tableName, entity.toMap(),
        where: "id=?", whereArgs: [entity.id]);
  }

  @override
  Future<Map<String, dynamic>> queryFirstAsync(String query,
      {List arguments}) async {
    var res = await _db.rawQuery(query, arguments);

    return res.first;
  }

  @override
  Future<List<Map<String, dynamic>>> queryMultipleAsync(String query,
      {List arguments}) async {
    var res = await _db.rawQuery(query, arguments);

    return res.toList();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:z_components/infra/entities/z-entity.dart';

class ZDatabase {
  List<ZEntity> entidades;
  int version;
  String dbName;

  Database _db;

  ZDatabase(
      {@required this.entidades,
      @required this.dbName,
      @required this.version});

  void init() async {
    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, dbName);

    _db = await openDatabase(path, version: this.version,
        onCreate: (db, version) {
      entidades.forEach((e) => e.createTable(db));
    });
  }
}
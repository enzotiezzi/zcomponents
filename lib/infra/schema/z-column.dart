import 'package:meta/meta.dart';

class ZColumn {
  int? version;

  String? name;
  String? type;
  bool? primaryKey;
  bool? autoIncrement;
  bool? notNull;

  ZColumn(
      {@required this.version,
      @required this.name,
      @required this.type,
      this.primaryKey,
      this.autoIncrement,
      this.notNull});
}

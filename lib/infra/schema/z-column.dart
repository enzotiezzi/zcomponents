class ZColumn{
  int version;

  String name;
  String type;
  bool primaryKey;
  bool autoIncrement;
  bool notNull;

  ZColumn({this.version, this.name, this.type, this.primaryKey, this.autoIncrement, this.notNull});
}
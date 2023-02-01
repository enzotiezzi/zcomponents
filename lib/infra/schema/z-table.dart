import 'package:z_components/infra/schema/z-column.dart';

class ZTable {
  int? version;

  List<ZColumn>? columns;

  ZTable({this.version, this.columns});
}

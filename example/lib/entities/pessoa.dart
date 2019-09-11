import 'package:z_components/infra/entities/z-entity.dart';
import 'package:z_components/infra/db/database-utils.dart';

class Pessoa extends ZEntity {
  Pessoa(){
    this.structure = {
      DatabaseUtils.TABLE_NAME: "Pessoa",
      DatabaseUtils.COLUMNS:[]
    };
  }

  @override
  Map toMap() {
    return {};
  }
}
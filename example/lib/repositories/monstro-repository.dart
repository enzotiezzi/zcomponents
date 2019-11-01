import 'package:z_components/infra/abstract-repository.dart';
import 'package:z_components_example/entities/monstro.dart';
import 'package:z_components_example/repositories/i-monstro-repository.dart';

class MonstroRepository extends AbstractRepository<Monstro> implements IMonstroRepository{
  @override
  Future<Monstro> findById(int id) async {
    var res = await db.queryFirstAsync("SELECT * FROM MONSTRO WHERE ID = ?", arguments: [id]);

    return new Monstro()..fromMap(res);
  }

  @override
  Future<Monstro> findLast() {
    // TODO: implement findLast
    return null;
  }
}
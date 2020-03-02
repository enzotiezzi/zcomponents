import 'package:z_components/components/z-log/i-z-log-repository.dart';
import 'package:z_components/components/z-log/z-log-entity.dart';
import 'package:z_components/infra/abstract-repository.dart';

class ZLogRepository extends AbstractRepository<ZLogEntity>
    implements IZLogRepository {
  @override
  Future<ZLogEntity> findById(int id) async {
    try {
      var res = await db
          .queryFirstAsync("SELECT * FROM ZLOG WHERE ID = ?", arguments: [id]);

      return new ZLogEntity().fromMap(res);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ZLogEntity> findLast() {
    // TODO: implement findLast
    return null;
  }

  @override
  Future<List<ZLogEntity>> listarLogsNaoSincronizados() async {
    try {
      var res =
          await db.queryMultipleAsync("SELECT * FROM ZLOG WHERE SYNC = 0");

      return res.map((x) => new ZLogEntity().fromMap(x)).toList();
    } catch (e) {
      return null;
    }
  }
}

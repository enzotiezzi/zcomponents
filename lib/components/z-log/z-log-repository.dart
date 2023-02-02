import 'package:z_components/components/z-log/i-z-log-repository.dart';
import 'package:z_components/components/z-log/z-log-entity.dart';
import 'package:z_components/infra/abstract-repository.dart';

class ZLogRepository extends AbstractRepository<ZLogEntity>
    implements IZLogRepository {
  @override
  Future<ZLogEntity> findById(int id) async{
    try {
      var res = await db
          .queryFirstAsync("SELECT * FROM ZLOG WHERE ID = ?", arguments: [id]);

      return  ZLogEntity().fromMap(res) as ZLogEntity;
    } catch (e) {
      return ZLogEntity();
    }
  }

  @override
  Future<ZLogEntity> findLast() async{
    // TODO: implement findLast
    return ZLogEntity();
  }

  @override
  Future<List<ZLogEntity?>?> listarLogsNaoSincronizados() async{
    try{
      var res =
          await db.queryMultipleAsync("SELECT * FROM ZLOG WHERE SYNC = 0");
      List<ZLogEntity?> a = await res.map((x) => new ZLogEntity().fromMap(x)).cast<ZLogEntity?>().toList();
      return a;
    }catch(e){
      return null;
    }
  }
  
}

import 'package:z_components/components/z-log/z-log-entity.dart';
import 'package:z_components/infra/interfaces/i-command.dart';
import 'package:z_components/infra/interfaces/i-query.dart';

abstract class IZLogRepository implements ICommand<ZLogEntity>, IQuery<ZLogEntity>{
  Future<List<ZLogEntity?>?> listarLogsNaoSincronizados();
}
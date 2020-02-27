import 'dart:async';

import 'package:z_components/api/z-log-service.dart';
import 'package:z_components/components/z-log/i-z-log-repository.dart';
import 'package:z_components/components/z-log/z-log-entity.dart';
import 'package:z_components/components/z-log/z-log-repository.dart';
import 'package:z_components/infra/db/database.dart';
import 'package:z_components/view-model/z-log-viewmodel.dart';

class ZLog {
  String token;

  ZLogService _logService;

  IZLogRepository _logRepository;

  Timer _logSync;

  ZLog({this.token});

  Future<void> initLog() async {
    var db =
        new ZDatabase(entities: [new ZLogEntity()], dbName: "ZLOG", version: 1);

    await db.init();

    _logService = new ZLogService(token);
    _logRepository = new ZLogRepository();

    _startLogWorker();
  }

  Future<bool> log(ZLogViewModel zLogViewModel) async {
    var res = await _logService.log(zLogViewModel);

    await _logRepository.insert(new ZLogEntity(
        user: zLogViewModel.user,
        errorMessage: zLogViewModel.errorMessage,
        when: zLogViewModel.when,
        app: zLogViewModel.app,
        payload: zLogViewModel.payload,
        method: zLogViewModel.method,
        sync: res));

    return res;
  }

  void _startLogWorker() {
    if (_logSync == null) {
      _logSync = new Timer(new Duration(minutes: 10), () async {
        var logs = await _logRepository.listarLogsNaoSincronizados();

        if (logs != null) {
          for (var i = 0; i < logs.length; i++) {
            var log = logs[i];

            var res = await _logService.log(new ZLogViewModel(
                user: log.user,
                errorMessage: log.errorMessage,
                when: log.when,
                payload: log.payload,
                method: log.method,
                app: log.app));

            if (res) {
              log.sync = true;

              await _logRepository.update(log);
            }
          }
        }
      });
    }
  }
}

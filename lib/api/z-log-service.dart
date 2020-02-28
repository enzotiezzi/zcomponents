import 'package:z_components/api/service.dart';
import 'package:z_components/settings/api-settings.dart';
import 'package:z_components/view-model/z-log-viewmodel.dart';

class ZLogService extends Service{
  String _URL = "${ApiSettings.ENDPOINT_API_V1}/log";

  ZLogService(String token) : super(token);

  Future<bool> log(ZLogViewModel zLogViewModel) async {
    try{
      var url = "${_URL}/log-error";

      var res = await request(url, Service.HTTP_POST, body: zLogViewModel.toMap());

      return res.statusCode == 200;
    }catch(e){
      return false;
    }
  }
}
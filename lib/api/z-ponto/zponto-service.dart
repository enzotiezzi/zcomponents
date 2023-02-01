import '../api-settings.dart';
import '../service.dart';
import 'i-zponto-service.dart';

class ZPontoService extends Service implements IZPontoService {
  String _URL = "${ApiSettings.ENDPOINT_API}/zponto";

  ZPontoService(String token) : super(token);

  @override
  Future<bool?> testarConexaoServidor() async {
    try {
      var url = "${_URL}/isAlive";

      var response = await request(url, Service.HTTP_GET);

      return response?.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

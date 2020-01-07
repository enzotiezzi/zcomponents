import 'dart:convert';
import 'package:z_components/api/service.dart';
import 'package:z_components/interface/i-zcargo-service.dart';
import 'package:z_components/settings/api-settings.dart';
import 'package:z_components/view-model/cargo-viewmodel.dart';
import 'package:http/http.dart' as http;

class ZCargoService extends Service implements IZCargoService {
  String _URL = "${ApiSettings.ENDPOINT}/zponto";

  final String token;

  ZCargoService(this.token) : super(token);

  @override
  Future<List<CargoViewModel>> listarCargos() async {
    try {
      var url = "$_URL/listar-cargos";

      var response = await http.get(url, headers: headers);

      var l = ((json.decode(response.body) as List)
          .map((i) => new CargoViewModel.fromJson(i))).toList();

      return l;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

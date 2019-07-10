import 'package:z_components/api/service.dart';
import 'package:z_components/interface/i-zlocal-service.dart';
import 'package:z_components/settings/api-settings.dart';
import 'package:z_components/view-model/centrocusto-viewmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class ZLocalService extends Service implements IZLocalService {
  String _uRL = "${ApiSettings.ENDPOINT}/zponto";

  final String token;
  final String idEmpresa;


  ZLocalService(this.token, this.idEmpresa) : super(token);

  @override
  Future<List<CentroCustoViewModel>> listarCentrosCusto() async {
    try {

      var url = "$_uRL/buscar-centros-custo-empresa/$idEmpresa";

      var response = await http.get(url, headers: await headers);

      var l = ((json.decode(response.body) as List)
          .map((i) => new CentroCustoViewModel.fromJson(i)))
          .toList();

      return l;
    } catch (e) {
      return null;
    }
  }

}
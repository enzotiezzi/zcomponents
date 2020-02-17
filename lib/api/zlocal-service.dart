import 'package:z_components/api/service.dart';
import 'package:z_components/interface/i-zlocal-service.dart';
import 'package:z_components/settings/api-settings.dart';
import 'package:z_components/view-model/centrocusto-viewmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:z_components/view-model/filtro-viewmodel.dart';

class ZLocalService extends Service implements IZLocalService {
  String _uRL = "${ApiSettings.ENDPOINT}/zponto";

  final String token;
  final FiltroViewModel filtro;

  ZLocalService(this.token, {this.filtro}) : super(token);

  @override
  Future<List<CentroCustoViewModel>> listarCentrosCusto(
      {FiltroViewModel filtro}) async {
    try {
      var url = "$_uRL/buscar-centros-custo-empresa";

      var response = await http.post(url,
          body: json.encode(filtro.toMap()), headers: headers);

      var l = ((json.decode(response.body) as List)
          .map((i) => new CentroCustoViewModel.fromJson(i))).toList();

      return l;
    } catch (e) {
      return null;
    }
  }
}

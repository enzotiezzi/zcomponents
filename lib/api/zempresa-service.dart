import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:z_components/api/service.dart';
import 'package:z_components/interface/i-zempresa-service.dart';
import 'package:z_components/settings/api-settings.dart';
import 'package:z_components/view-model/company-components-viewmodel.dart';

class ZEmpresaService extends Service implements IZEmpresaService {
  static final String _URL_API = "${ApiSettings.ENDPOINT}/empresas";

  final String token;
  final String idUser;

  ZEmpresaService(this.token,this.idUser) : super(token);

  @override
  Future<List<CompanyViewModel>> list() async {
    try {
      var url =
          "$_URL_API/buscar-empresa-por-usuario-app/${idUser}/ZPonto";
      var response = await http.get(url, headers: await headers);
      var l = (json.decode(response.body) as List)
          .map((i) => new CompanyViewModel.fromJson(i));
      return l.toList();
    } catch (e) {
      return null;
    }
  }
}
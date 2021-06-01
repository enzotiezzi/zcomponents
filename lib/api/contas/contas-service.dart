import 'dart:convert';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/api/service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/paginated-list.dart';
import 'package:z_components/components/filtro/z-response.dart';
import 'package:z_components/settings/api-settings.dart';
import 'package:z_components/view-model/info-organizacao-viewmodel.dart';
import 'package:z_components/view-model/usuario-conta-viewmodel.dart';

class ContasService extends Service implements IContasService {
  String _URL = "${ApiSettings.ENDPOINT_API_V1}/contas";

  ContasService(String token) : super(token);

  @override
  Future<ZResponse<UsuarioContaViewModel>> listarUsuariosConta(
      SearchOptions searchOptions) async {
    var params = searchOptions.toHttpParams();
    try {
      var res = await request("$_URL/usuarios$params", Service.HTTP_GET);
      print(res.body);
      return PaginatedList<UsuarioContaViewModel>(
              response: res, deserializer: UsuarioContaViewModel.fromJson)
          .mapToPaginatedList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<InfoOrganizacaoViewModel> buscarDadosOrganizacao(
      String idConta) async {
    try {
      var url = "$_URL/contas/$idConta";

      var response = await request(url, Service.HTTP_GET);

      return InfoOrganizacaoViewModel.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<InfoOrganizacaoViewModel> editarDadosOrganizacao(
      InfoOrganizacaoViewModel infoOrganizacaoViewModel) async {
    try {
      var url = "$_URL/contas/${infoOrganizacaoViewModel.idConta}";

      var response = await request(url, Service.HTTP_PUT,
          body: infoOrganizacaoViewModel.toMap());

      return InfoOrganizacaoViewModel.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }
}

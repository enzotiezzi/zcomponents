import 'dart:convert';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/api/service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/paginated-list.dart';
import 'package:z_components/components/filtro/z-response.dart';
import 'package:z_components/settings/api-settings.dart';
import 'package:z_components/view-model/app-view-model.dart';
import 'package:z_components/view-model/conta-v2-viewmodel.dart';
import 'package:z_components/view-model/info-organizacao-viewmodel.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/modulo-conta-viewmodel.dart';
import 'package:z_components/view-model/usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/perfil-viewmodel.dart';

class ContasService extends Service implements IContasService {
  String _URL = "${ApiSettings.ENDPOINT_API_V1}/contas";

  ContasService(String token) : super(token);

  @override
  Future<ZResponse<UsuarioContaViewModel>> listarUsuariosConta(
      SearchOptions searchOptions) async {
    var params = searchOptions.toHttpParams();
    try {
      var res = await request("$_URL/usuarios$params", Service.HTTP_GET);

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
  Future<AppUsuarioContaViewModel> buscarDadosUsuarioConta(
      String idUsuario) async {
    try {
      var url = "$_URL/usuarios/$idUsuario";
      var response = await request(url, Service.HTTP_GET);

      return AppUsuarioContaViewModel.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> editarDadosOrganizacao(
      InfoOrganizacaoViewModel infoOrganizacaoViewModel) async {
    try {
      var url = "$_URL/contas/${infoOrganizacaoViewModel.idConta}";

      var response = await request(url, Service.HTTP_PUT,
          body: infoOrganizacaoViewModel.toMap());

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else
        return null;
    } catch (e) {
      return null;
    }
  }

  Future modificarAcesso(
      AppUsuarioContaViewModel appUsuarioContaViewModel) async {
    var res = await request("$_URL/app-usuario-conta/acesso", Service.HTTP_PUT,
        body: appUsuarioContaViewModel.toMap());

    print(appUsuarioContaViewModel.status);
    print(res.statusCode.toString());
  }

  @override
  Future modificarAcessoAtivar(
      UsuarioContaViewModel usuarioContaViewModel) async {
    var res = await request(
        "$_URL/usuarios/${usuarioContaViewModel.idUsuario}/ativar",
        Service.HTTP_PUT,
        body: usuarioContaViewModel.toMap());
  }

  @override
  Future modificarAcessoBloquear(
      UsuarioContaViewModel usuarioContaViewModel) async {
    var res = await request(
        "$_URL/usuarios/${usuarioContaViewModel.idUsuario}/bloquear",
        Service.HTTP_PUT,
        body: usuarioContaViewModel.toMap());
  }

  @override
  Future modificarAcessoInativar(
      UsuarioContaViewModel usuarioContaViewModel) async {
    var res = await request(
        "$_URL/usuarios/${usuarioContaViewModel.idUsuario}/inativar",
        Service.HTTP_PUT,
        body: usuarioContaViewModel.toMap());
  }

  @override
  Future<ZResponse<ModuloContaViewModel>> listarModulosConta(
      SearchOptions searchOptions) async {
    print("chamou");
    var params = searchOptions.toHttpParams();
    try {
      var res = await request("$_URL/modulos$params", Service.HTTP_GET);
      print(res.body);
      print(res.statusCode);
      return PaginatedList<ModuloContaViewModel>(
              response: res, deserializer: ModuloContaViewModel.fromJson)
          .mapToPaginatedList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ZResponse<AppViewModel>> listarAplicativos(
      SearchOptions searchOptions, String idModulo) async {
    var params = searchOptions.toHttpParams();
    try {
      var url = "$_URL/modulos/${idModulo}/apps$params";
      var response = await request(url, Service.HTTP_GET);
      print(response.body);
      print(response.statusCode);
      return PaginatedList<AppViewModel>(
              response: response, deserializer: AppViewModel.fromJson)
          .mapToPaginatedList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ZResponse<AppUsuarioContaViewModel>> listarUsuariosPorModuloEApp(
      String idModulo, String idApp, SearchOptions searchOptions) async {
    var params = searchOptions.toHttpParams();
    try {
      var res = await request(
          "$_URL/modulos/${idModulo}/apps/$idApp/usuarios$params",
          Service.HTTP_GET);
      print(res.body);
      print(res.statusCode);
      return PaginatedList<AppUsuarioContaViewModel>(
              response: res, deserializer: AppUsuarioContaViewModel.fromJson)
          .mapToPaginatedList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ZResponse<ContaV2ViewModel>> listarContas(
      SearchOptions searchOptions) async {
    var params = searchOptions.toHttpParams();
    try {
      var res = await request("$_URL/usuarios/contas$params", Service.HTTP_GET);
      print(res.body);
      return PaginatedList<ContaV2ViewModel>(
              response: res, deserializer: ContaV2ViewModel.fromJson)
          .mapToPaginatedList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> editarDadosUsuario(
      String idModulo,
      String idApp,
      String idUsuario,
      AppUsuarioContaViewModel appUsuarioContaViewModel,
      String tipo) async {
    try {
      print(appUsuarioContaViewModel.toMap());
      var res = await request(
          "$_URL/modulos/$idModulo/apps/$idApp/usuarios/$idUsuario/$tipo",
          Service.HTTP_PUT,
          body: appUsuarioContaViewModel.toMap());
      print(res.body);
      print(res.statusCode);
      if (res.statusCode == 200 || res.statusCode == 204) {
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editarDadosFluxoUsuario(
      String idModulo,
      String idApp,
      String idUsuario,
      AppUsuarioContaViewModel appUsuarioContaViewModel,
      String tipo) async {
    try {
      print(appUsuarioContaViewModel.toMap());
      var res = await request(
          "$_URL/usuarios/$idUsuario/modulos/$idModulo/apps/$idApp/$tipo",
          Service.HTTP_PUT,
          body: appUsuarioContaViewModel.toMap());
      print(res.body);
      print(res.statusCode);
      if (res.statusCode == 200 || res.statusCode == 204) {
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<ZResponse<PerfilViewModel>> buscarListaPerfis(
      SearchOptions searchOptions, String idApp) async {
    var params = searchOptions.toHttpParams();
    try {
      var res =
          await request("$_URL/app/$idApp/perfil$params", Service.HTTP_GET);
      print(res.body);
      return PaginatedList<PerfilViewModel>(
              response: res, deserializer: PerfilViewModel.fromJson)
          .mapToPaginatedList();
    } catch (e) {
      return null;
    }
  }

  Future<bool> alterarConta(String idConta) async {
    try {
      var res = await request(
          "$_URL/usuarios/contas/$idConta/selecionar",
          Service.HTTP_PUT,
        );
      print(res.statusCode);
      if (res.statusCode == 200 || res.statusCode == 204) {
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }
}

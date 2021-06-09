import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-response.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/app-view-model.dart';
import 'package:z_components/view-model/conta-v2-viewmodel.dart';
import 'package:z_components/view-model/info-organizacao-viewmodel.dart';
import 'package:z_components/view-model/modulo-conta-viewmodel.dart';
import 'package:z_components/view-model/usuario-conta-viewmodel.dart';

abstract class IContasService {
  Future<ZResponse<UsuarioContaViewModel>> listarUsuariosConta(
      SearchOptions searchOptions);

  Future<InfoOrganizacaoViewModel> buscarDadosOrganizacao(String idConta);

  Future<InfoOrganizacaoViewModel> editarDadosOrganizacao(
      InfoOrganizacaoViewModel infoOrganizacaoViewModel);

  Future modificarAcesso(AppUsuarioContaViewModel appUsuarioContaViewModel);

  Future<ZResponse<ModuloContaViewModel>> listarModulosConta(
      SearchOptions searchOptions);

  Future<List<AppViewModel>> listarAplicativos(String idModulo);

  Future<ZResponse<AppUsuarioContaViewModel>> listarUsuariosPorModuloEApp(
      String idModulo, String idApp);

  Future<ZResponse<ContaV2ViewModel>> listarContas(SearchOptions searchOptions);
}

import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-response.dart';
import 'package:z_components/view-model/app-usuario-conta-viewmodel.dart';
import 'package:z_components/view-model/usuario-conta-viewmodel.dart';

abstract class IContasService {
  Future<ZResponse<UsuarioContaViewModel>> listarUsuariosConta( SearchOptions searchOptions);
  Future modificarAcesso( AppUsuarioContaViewModel appUsuarioContaViewModel );
}

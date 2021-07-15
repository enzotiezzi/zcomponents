import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-response.dart';

import 'nivel.dart';

abstract class IEstruturaEmpresaService {
  Future<ZResponse<Nivel>> listarNiveis(SearchOptions searchOptions);
}
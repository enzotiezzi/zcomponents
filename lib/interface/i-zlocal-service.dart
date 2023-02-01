import 'package:z_components/view-model/centrocusto-viewmodel.dart';
import 'package:z_components/view-model/filtro-viewmodel.dart';

abstract class IZLocalService {
  Future<List<CentroCustoViewModel>?> listarCentrosCusto(
      {FiltroViewModel? filtro});
}

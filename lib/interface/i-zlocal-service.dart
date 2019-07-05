import 'package:z_components/view-model/centrocusto-viewmodel.dart';

abstract class IZLocalService{
  Future<List<CentroCustoViewModel>> listarCentrosCusto();

}
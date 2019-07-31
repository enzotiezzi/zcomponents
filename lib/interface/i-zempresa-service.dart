import 'package:z_components/view-model/company-components-viewmodel.dart';

abstract class IZEmpresaService{

  Future<List<CompanyViewModel>> list();
}
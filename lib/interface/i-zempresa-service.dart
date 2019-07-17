import 'package:z_components/view-model/company-viewmodel.dart';

abstract class IZEmpresaService{

  Future<List<CompanyViewModel>> list();
}
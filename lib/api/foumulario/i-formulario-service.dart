import 'package:z_components/view-model/z-dynamic-form-viewmodel.dart';

abstract class IFormularioService {
  Future<List<ZDynamicFormViewModel>> buscarFormularios();

  Future<List<ZDynamicFormViewModel>> montarFormulario(String idModelo);
}

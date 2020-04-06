import 'package:z_components/view-model/z-dynamic-form-viewmodel.dart';
import 'package:z_components/view-model/z-dynamic-model-viewmodel.dart';

abstract class IFormularioService {
  Future<List<ZDynamicModelViewModel>> buscarFormularios();

  Future<List<ZDynamicFormViewModel>> montarFormulario(String idModelo);
}

import 'package:z_components/view-model/escala-viewmodel.dart';

abstract class IZEscalaService {
  Future<List<EscalaViewModel>> listarEscalas();
}

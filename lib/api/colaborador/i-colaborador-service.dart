
import 'package:z_components/view-model/colaborador-viewmodel.dart';

abstract class IColaboradorService {
  Future<List<ColaboradorViewModel>?> buscarColaboradores(String re);
}

import 'package:z_components/view-model/colaborador-viewmodel.dart';

abstract class IZColaboradorService {
  Future<ColaboradorViewModel?> buscarPerfilColaborador();
}

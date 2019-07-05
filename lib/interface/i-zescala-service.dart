import 'package:z_components/view-model/EscalaViewModel.dart';

abstract class IZEscalaService{

  Future<List<EscalaViewModel>> listarEscalas();
}
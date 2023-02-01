import 'package:z_components/view-model/cargo-viewmodel.dart';

abstract class IZCargoService {
  Future<List<CargoViewModel>?> listarCargos();
}

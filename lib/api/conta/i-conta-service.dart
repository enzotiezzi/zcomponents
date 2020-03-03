import 'package:z_components/view-model/conta-view-model.dart';

abstract class IContaServce{
  Future<List<ContaViewModel>> listarContasUsuario();
}
import 'package:z_components/view-model/conta-view-model.dart';

abstract class IContaServce{
  Future<List<ContaViewModel>> listarContasUsuario();
  Future<ContaViewModel> localizarConta(String codigoAtivacao);
  Future<bool> associarConta(String idConta);
  Future<bool> trocarContaAtiva(String idConta);
}
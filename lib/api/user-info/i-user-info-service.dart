import 'package:z_components/components/z-identity-server/token-info.dart';
import 'package:z_components/view-model/buscarinfo-viewmodel.dart';

abstract class IUserInfoService {
  Future<bool?> editarInformacoes(BuscarInfo input);

  Future<BuscarInfo?> buscarInformacoesUsuarioPessoa();
}

import 'package:z_components/components/z-identity-server/token-info.dart';

abstract class IUserInfoService {
  Future<bool> editarInformacoes(UserInfo input);

  Future<UserInfo> buscarInformacoesUsuarioPessoa();
}

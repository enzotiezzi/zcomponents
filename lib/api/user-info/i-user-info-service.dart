import 'package:z_components/components/z-identity-server/token-info.dart';

abstract class IUserInfoService{
  Future<UserInfo> editarInformacoes(UserInfo input);
}
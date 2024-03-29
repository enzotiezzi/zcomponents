import 'package:z_components/components/z-identity-server/token-info.dart';

abstract class IIdentityServer {
  Future refreshToken();

  Future login();

  UserInfo getUserInfo();

  Future setIdColaborador();

  Future setUserInfo({String token});

  Future logout(Function function, {String token});

  Future<String> getCurrentIdAccount();

  Future<Null> forceRefreshToken();
}

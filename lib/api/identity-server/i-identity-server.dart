import 'package:z_components/components/z-identity-server/token-info.dart';

abstract class IIdentityServer {
  Future refreshToken();

  Future login();

  Future reLogin();

  TokenInfo getUserClaims();

  Future setIdColaborador();

  Future setUserInfo();

  Future logout(Function function, {String token});

  Future<String> getCurrentIdAccount();

  Future<Null> forceRefreshToken();
}

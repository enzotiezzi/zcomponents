import 'package:z_components/view-model/user-claims.dart';

abstract class IIdentityServer {
  Future getRefreshToken();

  Future login();

  UserClaims getUserClaims();

  Future setIdColaborador();

  Future setUserInfo();
}

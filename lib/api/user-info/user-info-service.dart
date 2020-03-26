import 'dart:convert';

import 'package:z_components/api/service.dart';
import 'package:z_components/api/user-info/i-user-info-service.dart';
import 'package:z_components/components/z-identity-server/token-info.dart';
import 'package:z_components/settings/api-settings.dart';

class UserInfoService extends Service implements IUserInfoService {
  var _URL = "${ApiSettings.ENDPOINT_API_V1}/";

  UserInfoService(String token) : super(token);

  @override
  Future<UserInfo> editarInformacoes(UserInfo input) async {
    try {
      var url = "$_URL/";

      var response = await request(url, Service.HTTP_POST, body: input.toMap());

      return UserInfo.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }
}

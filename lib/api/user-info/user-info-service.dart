import 'dart:convert';

import 'package:z_components/api/service.dart';
import 'package:z_components/api/user-info/i-user-info-service.dart';
import 'package:z_components/components/z-identity-server/token-info.dart';
import 'package:z_components/settings/api-settings.dart';

class UserInfoService extends Service implements IUserInfoService {
  var _URL = "https://identity-server-dev.zellar.com.br/apis";

  UserInfoService(String token) : super(token);

  @override
  Future<bool> editarInformacoes(UserInfo input) async {
    try {
      var url = "$_URL/usuario-pessoa";

      var response = await request(url, Service.HTTP_PUT, body: input.toMap());

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserInfo> buscarInformacoesUsuarioPessoa() async{
    try {
      var url = "$_URL/usuario-pessoa";

      var response = await request(url, Service.HTTP_GET);

      return UserInfo.fromJson(json.decode(response.body));
    } catch(e){
      return null;
    }
  }
}

import 'dart:convert';
import 'package:z_components/api/service.dart';
import 'package:z_components/api/user-info/i-user-info-service.dart';
import 'package:z_components/view-model/buscarinfo-viewmodel.dart';

class UserInfoService extends Service implements IUserInfoService {
  var _URL = "https://identity-server-dev.zellar.com.br/apis";

  UserInfoService(String token) : super(token);

  @override
  Future<bool> editarInformacoes(BuscarInfo input) async {
    try {
      var url = "$_URL/usuario-pessoa";

      var response = await request(url, Service.HTTP_PUT, body: input.toMap());

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<BuscarInfo> buscarInformacoesUsuarioPessoa() async{
    try {
      var url = "$_URL/usuario-pessoa";

      var response = await request(url, Service.HTTP_GET);

      return BuscarInfo.fromJson(json.decode(response.body));
    } catch(e){
      return null;
    }
  }
}

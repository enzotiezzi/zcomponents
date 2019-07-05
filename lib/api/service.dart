import 'dart:io';
import 'dart:collection';

abstract class Service{

  final String token;

  Map<String, String> headers = new HashMap<String, String>();

  Service(this.token){
    init();
  }

  init() async {
    headers[HttpHeaders.contentTypeHeader] = "application/json";
    headers[HttpHeaders.authorizationHeader] = "Bearer ${token}";
  }

}
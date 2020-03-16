import 'dart:convert';
import 'dart:io';
import 'dart:collection';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

abstract class Service {
  static const String HTTP_GET = "HTTP_GET";
  static const String HTTP_POST = "HTTP_POST";
  static const String HTTP_PUT = "HTTP_PUT";
  static const String HTTP_PATCH = "HTTP_PATCH";
  static const String HTTP_DELETE = "HTTP_DELETE";

  final String token;

  String serverErrorMessage = "";
  String exceptionMessage = "";
  Map<String, String> headers = new HashMap<String, String>();

  Service(this.token);

  Future buildAuthorizationHeaders() async {
    headers = {};

    headers[HttpHeaders.authorizationHeader] = "Bearer $token";
  }

  Future<http.Response> request(String url, String method,
      {dynamic body, int timeout = 15}) async {
    http.Response response;

    try {
      await buildAuthorizationHeaders();

      if (body != null)
        headers[HttpHeaders.contentTypeHeader] = "application/json";

      switch (method) {
        case HTTP_GET:
          response = await http
              .get(url, headers: this.headers)
              .timeout(new Duration(seconds: timeout));
          break;
        case HTTP_POST:
          response = await http
              .post(url,
                  body: body != null ? json.encode(body) : {},
                  headers: this.headers)
              .timeout(new Duration(seconds: timeout));
          break;
        case HTTP_PUT:
          response = await http
              .put(url,
                  body: body != null ? json.encode(body) : {},
                  headers: this.headers)
              .timeout(new Duration(seconds: timeout));
          break;
        case HTTP_PATCH:
          response = await http
              .patch(url,
                  body: body != null ? json.encode(body) : {},
                  headers: this.headers)
              .timeout(new Duration(seconds: timeout));
          break;
        case HTTP_DELETE:
          response = await http
              .delete(url, headers: this.headers)
              .timeout(new Duration(seconds: timeout));
          break;
      }

      return response;
    } catch (e) {
      serverErrorMessage = response.body;
      exceptionMessage = e;
      return null;
    }
  }
}

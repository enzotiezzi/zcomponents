import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-response.dart';

class PaginatedList<T> {
  Function(Map<String, dynamic>) deserializer;
  final Response response;

  PaginatedList({@required this.response, @required this.deserializer});

  ZResponse<T> mapToPaginatedList() {
    String pagination = response.headers["x-pagination"];

    PaginationMetaData paginationMetaData;

    if (pagination != null)
      paginationMetaData = PaginationMetaData.fromJson(jsonDecode(pagination));

    List<T> list = [];

    if (response.body.length > 0)
      list = (jsonDecode(response.body) as List)
          .map<T>((e) => deserializer(e))
          .toList();

    return new ZResponse<T>(
        paginationMetaData: paginationMetaData, body: list);
  }
}

import 'filter-expression.dart';

class ZResponse<T> {
  final PaginationMetaData? paginationMetaData;
  final List<T>? body;

  ZResponse({
    this.paginationMetaData,
    this.body
  });
}
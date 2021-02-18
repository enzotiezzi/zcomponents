class FilterExpression {
  String propertyName;
  dynamic value;
  String operator;
  String operatorBetween;
}

class OrderByExpression {
  String propertyName;
  String orientation;
}

class SearchOptions {
  Pagination pagination;
  List<FilterExpression> filters;
  List<OrderByExpression> orders;
}

class Pagination {
  int pageNumber;
  int pageSize;
}

class PaginationMetaData {
  int currentPage;
  int totalPages;
  int pageSize;
  int totalCount;
  bool hasPrevious;
  bool hasNext;

  PaginationMetaData({
    this.currentPage,
    this.totalPages,
    this.pageSize,
    this.totalCount,
    this.hasPrevious,
    this.hasNext
  });

  factory PaginationMetaData.fromJson(Map<String, dynamic> json) {
    return new PaginationMetaData(
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
      pageSize: json["pageSize"],
      totalCount: json["totalCount"],
      hasPrevious: json["hasPrevious"],
      hasNext: json["hasNext"]
    );
  }
}
class FilterExpression {
  String? propertyName;
  dynamic value;
  String? operator;
  String? operatorBetween;

  FilterExpression(
      {this.value, this.propertyName, this.operator, this.operatorBetween});
}

class OrderByExpression {
  String? propertyName;
  String? orientation;

  OrderByExpression({this.propertyName, this.orientation});
}

class SearchOptions {
  late Pagination? pagination;
  late List<FilterExpression>? filters;
  late List<OrderByExpression>? orders;

  SearchOptions() {
    filters = [];
    orders = [];
    pagination = new Pagination();
  }

  String toHttpParams() {
    Map<String, String> params = {};

    for(var i = 0; i < filters!.length; i++) {
      var filter = filters![i];

      params["Filters[$i].propertyName"] = filter.propertyName!;
      params["Filters[$i].value"] = filter.value;
      params["Filters[$i].operator"] = filter.operator!;
      params["Filters[$i].operatorBetween"] = filter.operatorBetween!;
    }

    for(var i = 0; i < orders!.length; i++) {
      var order = orders![i];

      params["Orders[$i].propertyName"] = order.propertyName!;
      params["Orders[$i].orientation"] = order.orientation!;
    }

    params["Pagination.PageNumber"] = pagination!.pageNumber.toString();
    params["Pagination.PageSize"] = pagination!.pageSize.toString();

    return Uri.https("","", params).toString().replaceAll("https:", "");
  }
}

class Pagination {
  late int? pageNumber;
  late int? pageSize;

  Pagination() {
    pageNumber = 1;
    pageSize = 20;
  }
}

class PaginationMetaData {
  late int? currentPage;
  late int? totalPages;
  late int? pageSize;
  late int? totalCount;
  late bool? hasPrevious;
  late bool? hasNext;

  PaginationMetaData(
      {this.currentPage,
      this.totalPages,
      this.pageSize,
      this.totalCount,
      this.hasPrevious,
      this.hasNext});

  factory PaginationMetaData.fromJson(Map<String, dynamic> json) {
    return new PaginationMetaData(
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        pageSize: json["pageSize"],
        totalCount: json["totalCount"],
        hasPrevious: json["hasPrevious"],
        hasNext: json["hasNext"]);
  }
}

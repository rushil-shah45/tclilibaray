import 'dart:convert';

ReadPageResponseModel readPageResponseModelFromJson(String str) =>
    ReadPageResponseModel.fromJson(json.decode(str));

String readPageResponseModelToJson(ReadPageResponseModel data) =>
    json.encode(data.toJson());

class ReadPageResponseModel {
  final bool status;
  final int code;
  final String msg;
  final String error;
  final Data data;
  final dynamic description;

  ReadPageResponseModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.error,
    required this.data,
    required this.description,
  });

  factory ReadPageResponseModel.fromJson(Map<String, dynamic> json) =>
      ReadPageResponseModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        error: json["error"],
        data: Data.fromJson(json["data"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "msg": msg,
    "error": error,
    "data": data.toJson(),
    "description": description,
  };
}

class Data {
  final DataPageView pageView;
  final Viewed viewed;
  final bool isPageComplete;
  final bool isBookComplete;

  Data({
    required this.pageView,
    required this.viewed,
    required this.isPageComplete,
    required this.isBookComplete,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pageView: DataPageView.fromJson(json["page_view"]),
    viewed: Viewed.fromJson(json["viewed"]),
    isPageComplete: json["is_page_complete"],
    isBookComplete: json["is_book_complete"],
  );

  Map<String, dynamic> toJson() => {
    "page_view": pageView.toJson(),
    "viewed": viewed.toJson(),
    "is_page_complete": isPageComplete,
    "is_book_complete": isBookComplete,
  };
}

class DataPageView {
  final int id;
  final String productViewId;
  final dynamic productId;
  final dynamic userId;
  final int totalView;
  final dynamic pageNo;
  final int pageTotalTime;
  final String pageStayTime;
  final dynamic status;
  final dynamic createBy;
  final dynamic updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  DataPageView({
    required this.id,
    required this.productViewId,
    required this.productId,
    required this.userId,
    required this.totalView,
    required this.pageNo,
    required this.pageTotalTime,
    required this.pageStayTime,
    required this.status,
    required this.createBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataPageView.fromJson(Map<String, dynamic> json) => DataPageView(
    id: json["id"],
    productViewId: "${json["product_view_id"]}",
    productId: json["product_id"] is int ? json["product_id"] : "${json["product_id"]}",
    userId: json["user_id"] is int ? json["user_id"] : "${json["user_id"]}",
    totalView: json["total_view"],
    pageNo: json["page_no"] is int ? json["page_no"] : "${json["page_no"]}",
    pageTotalTime: json["page_total_time"],
    pageStayTime: "${json["page_stay_time"]}",
    status: json["status"],
    createBy: json["create_by"],
    updatedBy: json["updated_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_view_id": productViewId,
    "product_id": productId is int ? productId : productId.toString(),
    "user_id": userId is int ? userId : userId.toString(),
    "total_view": totalView,
    "page_no": pageNo is int ? pageNo : pageNo.toString(),
    "page_total_time": pageTotalTime,
    "page_stay_time": pageStayTime,
    "status": status,
    "create_by": createBy,
    "updated_by": updatedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Viewed {
  final int id;
  final dynamic productId;
  final dynamic userId;
  final dynamic totalView;
  final String? progress;
  final String currentPage;
  final String pageStayTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String totalPage;
  final dynamic totalTime;
  final String stayTime;
  final dynamic status;
  final DateTime lastView;
  final List<PageViewElement> pageViews;

  Viewed({
    required this.id,
    required this.productId,
    required this.userId,
    required this.totalView,
    required this.progress,
    required this.currentPage,
    required this.pageStayTime,
    required this.createdAt,
    required this.updatedAt,
    required this.totalPage,
    required this.totalTime,
    required this.stayTime,
    required this.status,
    required this.lastView,
    required this.pageViews,
  });

  factory Viewed.fromJson(Map<String, dynamic> json) => Viewed(
    id: json["id"],
    productId: json["product_id"] is int ? json["product_id"] : "${json["product_id"]}",
    userId: json["user_id"] is int ? json["user_id"] : "${json["user_id"]}",
    totalView: json["total_view"] is int ? json["total_view"] : "${json["total_view"]}",
    progress: json["progress"],
    currentPage: json["current_page"],
    pageStayTime: "${json["page_stay_time"] ?? 0}",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    totalPage: json["total_page"],
    totalTime: json["total_time"] is int ? json["total_time"] : "${json["total_time"]}",
    stayTime: "${json["stay_time"]}",
    status: json["status"],
    lastView: DateTime.parse(json["last_view"]),
    pageViews: List<PageViewElement>.from(
        json["page_views"].map((x) => PageViewElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId is int ? productId : productId.toString(),
    "user_id": userId is int ? userId : userId.toString(),
    "total_view": totalView is int ? totalView : totalView.toString(),
    "progress": progress,
    "current_page": currentPage,
    "page_stay_time": pageStayTime,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "total_page": totalPage,
    "total_time": totalTime is int ? totalTime : totalTime.toString(),
    "stay_time": stayTime,
    "status": status,
    "last_view": lastView.toIso8601String(),
    "page_views": List<dynamic>.from(pageViews.map((x) => x.toJson())),
  };
}

class PageViewElement {
  final int id;
  final dynamic productViewId;
  final dynamic productId;
  final dynamic userId;
  final dynamic totalView;
  final dynamic pageNo;
  final dynamic pageTotalTime;
  final dynamic pageStayTime;
  final dynamic status;
  final dynamic createBy;
  final dynamic updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  PageViewElement({
    required this.id,
    required this.productViewId,
    required this.productId,
    required this.userId,
    required this.totalView,
    required this.pageNo,
    required this.pageTotalTime,
    required this.pageStayTime,
    required this.status,
    required this.createBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PageViewElement.fromJson(Map<String, dynamic> json) =>
      PageViewElement(
        id: json["id"],
        productViewId: json["product_view_id"] is int ? json["product_view_id"] : "${json["product_view_id"]}",
        productId: json["product_id"] is int ? json["product_id"] : "${json["product_id"]}",
        userId: json["user_id"] is int ? json["user_id"] : "${json["user_id"]}",
        totalView: json["total_view"] is int ? json["total_view"] : "${json["total_view"]}",
        pageNo: json["page_no"] is int ? json["page_no"] : "${json["page_no"]}",
        pageTotalTime: json["page_total_time"] is int ? json["page_total_time"] : "${json["page_total_time"]}",
        pageStayTime: json["page_stay_time"] is int ? json["page_stay_time"] : "${json["page_stay_time"]}",
        status: json["status"],
        createBy: json["create_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_view_id": productViewId is int ? productViewId : productViewId.toString(),
    "product_id": productId is int ? productId : productId.toString(),
    "user_id": userId is int ? userId : userId.toString(),
    "total_view": totalView is int ? totalView : totalView.toString(),
    "page_no": pageNo is int ? pageNo : pageNo.toString(),
    "page_total_time": pageTotalTime is int ? pageTotalTime : pageTotalTime.toString(),
    "page_stay_time": pageStayTime is int ? pageStayTime : pageStayTime.toString(),
    "status": status,
    "create_by": createBy,
    "updated_by": updatedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

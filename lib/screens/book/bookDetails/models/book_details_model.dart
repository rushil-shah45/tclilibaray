import 'dart:convert';

import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/model/profile_model.dart';

class BookDetailsModel {
  Book book;
  UserProfileModel user;
  List<Review> reviews;
  Progress progress;
  bool authReview;
  String avgRating;
  int totalReview;

  BookDetailsModel({
    required this.book,
    required this.user,
    required this.reviews,
    required this.progress,
    required this.authReview,
    required this.avgRating,
    required this.totalReview,
  });

  factory BookDetailsModel.fromJson(Map<String, dynamic> json) =>
      BookDetailsModel(
        book: Book.fromMap(json["book"]),
        user: UserProfileModel.fromMap(json["user"]),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        progress: Progress.fromJson(json["progress"]),
        authReview: json["auth_review"],
        avgRating: json["avg_rating"],
        totalReview: json["total_review"],
      );

  Map<String, dynamic> toJson() => {
        "book": book.toMap(),
        "user": user.toMap(),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "progress": progress.toJson(),
        "auth_review": authReview,
        "avg_rating": avgRating,
        "total_review": totalReview,
      };
}

class Review {
  int id;
  int userId;
  String bookId;
  String review;
  String rating;
  String status;
  String createdAt;
  String updatedAt;
  UserProfileModel user;

  Review({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.review,
    required this.rating,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user_id"],
        bookId: json["book_id"],
        review: json["review"] ?? '',
        rating: json["rating"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: UserProfileModel.fromMap(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "book_id": bookId,
        "review": review,
        "rating": rating,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user.toMap(),
      };
}


class Progress {
  final int? id;
  final dynamic productId;
  final String? userId;
  final int? totalView;
  final dynamic progress;
  final dynamic currentPage;
  final dynamic pageStayTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic totalPage;
  final int? totalTime;
  final dynamic stayTime;
  final dynamic status;
  final DateTime? lastView;
  final String? totalReadingTime;

  Progress({
    this.id,
    this.productId,
    this.userId,
    this.totalView,
    this.progress,
    this.currentPage,
    this.pageStayTime,
    this.createdAt,
    this.updatedAt,
    this.totalPage,
    this.totalTime,
    this.stayTime,
    this.status,
    this.lastView,
    this.totalReadingTime,
  });

  Progress copyWith({
    int? id,
    dynamic productId,
    String? userId,
    int? totalView,
    dynamic progress,
    dynamic currentPage,
    dynamic pageStayTime,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic totalPage,
    int? totalTime,
    dynamic stayTime,
    dynamic status,
    DateTime? lastView,
    String? totalReadingTime,
  }) =>
      Progress(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        userId: userId ?? this.userId,
        totalView: totalView ?? this.totalView,
        progress: progress ?? this.progress,
        currentPage: currentPage ?? this.currentPage,
        pageStayTime: pageStayTime ?? this.pageStayTime,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        totalPage: totalPage ?? this.totalPage,
        totalTime: totalTime ?? this.totalTime,
        stayTime: stayTime ?? this.stayTime,
        status: status ?? this.status,
        lastView: lastView ?? this.lastView,
        totalReadingTime: totalReadingTime ?? this.totalReadingTime,
      );

  factory Progress.fromRawJson(String str) => Progress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
    id: json["id"],
    productId: json["product_id"],
    userId: json["user_id"] is int ? json["user_id"].toString() : json["user_id"],
    totalView: json["total_view"],
    progress: json["progress"],
    currentPage: json["current_page"],
    pageStayTime: json["page_stay_time"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    totalPage: json["total_page"],
    totalTime: json["total_time"],
    stayTime: json["stay_time"],
    status: json["status"],
    lastView: json["last_view"] == null ? null : DateTime.parse(json["last_view"]),
    totalReadingTime: json["total_reading_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "user_id": userId,
    "total_view": totalView,
    "progress": progress,
    "current_page": currentPage,
    "page_stay_time": pageStayTime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "total_page": totalPage,
    "total_time": totalTime,
    "stay_time": stayTime,
    "status": status,
    "last_view": lastView?.toIso8601String(),
    "total_reading_time": totalReadingTime,
  };
}

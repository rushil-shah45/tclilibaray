import 'dart:convert';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/model/profile_model.dart';

class DashboardInstitutionModel {
  final List<LastViewedBook> lastViewedBooks;
  final List<LastIssuedBook> lastIssuedBooks;
  final int totalViewedBooks;
  final int totalIssuedBooks;
  final int totalFavBooks;
  final UserProfileModel user;
  final int unreadNotificationCount;
  final String tawkSrc;

  DashboardInstitutionModel({
    required this.lastViewedBooks,
    required this.lastIssuedBooks,
    required this.totalViewedBooks,
    required this.totalIssuedBooks,
    required this.totalFavBooks,
    required this.user,
    required this.unreadNotificationCount,
    required this.tawkSrc,
  });

  factory DashboardInstitutionModel.fromJson(String str) =>
      DashboardInstitutionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toJson());

  factory DashboardInstitutionModel.fromMap(Map<String, dynamic> json) =>
      DashboardInstitutionModel(
        lastViewedBooks: (json["last_viewed_books"] as List<dynamic>?)
                ?.map((x) => LastViewedBook.fromMap(x))
                .toList() ??
            [],
        lastIssuedBooks: (json["last_issued_books"] as List<dynamic>?)
                ?.map((x) => LastIssuedBook.fromMap(x))
                .toList() ??
            [],
        totalViewedBooks: json["total_viewed_books"] ?? 0,
        totalIssuedBooks: json["total_issued_books"] ?? 0,
        totalFavBooks: json["total_fav_books"] ?? 0,
        user: UserProfileModel.fromMap(json["user"]),
        unreadNotificationCount: json["unreadNotificationCount"],
        tawkSrc: json["tawk_chat_url"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "last_viewed_books":
            List<dynamic>.from(lastViewedBooks.map((x) => x.toMap())),
        "last_issued_books":
            List<dynamic>.from(lastIssuedBooks.map((x) => x.toMap())),
        "total_viewed_books": totalViewedBooks,
        "total_issued_books": totalIssuedBooks,
        "total_fav_books": totalFavBooks,
        "user": user.toMap(),
        "unreadNotificationCount": unreadNotificationCount,
        "tawk_chat_url": tawkSrc,
      };
}

class LastViewedBook {
  final int id;
  final dynamic productId;
  final dynamic userId;
  final dynamic totalView;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Book? book;

  LastViewedBook({
    required this.id,
    required this.productId,
    required this.userId,
    required this.totalView,
    required this.createdAt,
    required this.updatedAt,
    required this.book,
  });

  factory LastViewedBook.fromJson(String str) =>
      LastViewedBook.fromMap(json.decode(str));

  String toJson() => json.encode(toJson());

  factory LastViewedBook.fromMap(Map<String, dynamic> json) => LastViewedBook(
        id: json["id"],
        productId: json["product_id"] ?? '',
        userId: json["user_id"] ?? '',
        totalView: json["total_view"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        book: json["book"] == null ? null : Book.fromMap(json["book"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "total_view": totalView,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "book": book?.toMap(),
      };
}

class LastIssuedBook {
  final int id;
  final String userId;
  final String productId;
  final String isValid;
  final dynamic borrowedStartdate;
  final dynamic borrowedEnddate;
  final dynamic borrowedNextdate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String isInstitution;
  final Book? book;

  LastIssuedBook({
    required this.id,
    required this.userId,
    required this.productId,
    required this.isValid,
    required this.borrowedStartdate,
    required this.borrowedEnddate,
    required this.borrowedNextdate,
    required this.createdAt,
    required this.updatedAt,
    required this.isInstitution,
    required this.book,
  });

  factory LastIssuedBook.fromJson(String str) =>
      LastIssuedBook.fromMap(json.decode(str));

  String toJson() => json.encode(toJson());

  factory LastIssuedBook.fromMap(Map<String, dynamic> json) => LastIssuedBook(
        id: json["id"],
        userId: json["user_id"] ?? '',
        productId: json["product_id"] ?? '',
        isValid: json["is_valid"] ?? '',
        borrowedStartdate: json["borrowed_startdate"] != null
            ? DateTime.parse(json["borrowed_startdate"])
            : null,
        borrowedEnddate: json["borrowed_enddate"] != null
            ? DateTime.parse(json["borrowed_enddate"])
            : null,
        borrowedNextdate: json["borrowed_nextdate"] != null
            ? DateTime.parse(json["borrowed_nextdate"])
            : null,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isInstitution: json["is_institution"] ?? '',
        book: json["book"] == null ? null : Book.fromMap(json["book"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "is_valid": isValid,
        "borrowed_startdate":
            "${borrowedStartdate.year.toString().padLeft(4, '0')}-${borrowedStartdate.month.toString().padLeft(2, '0')}-${borrowedStartdate.day.toString().padLeft(2, '0')}",
        "borrowed_enddate":
            "${borrowedEnddate.year.toString().padLeft(4, '0')}-${borrowedEnddate.month.toString().padLeft(2, '0')}-${borrowedEnddate.day.toString().padLeft(2, '0')}",
        "borrowed_nextdate":
            "${borrowedNextdate.year.toString().padLeft(4, '0')}-${borrowedNextdate.month.toString().padLeft(2, '0')}-${borrowedNextdate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_institution": isInstitution,
        "book": book?.toMap(),
      };
}

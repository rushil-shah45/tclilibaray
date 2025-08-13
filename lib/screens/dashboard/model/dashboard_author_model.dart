import 'dart:convert';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/model/profile_model.dart';

class DashboardAuthorModel {
  final int readersCount;
  final List<TopReader> topReaders;
  final List<Book> myBooks;
  final List<Book> pendingBooks;
  final List<Book> declineBooks;
  final UserProfileModel user;
  final int unreadNotificationCount;
  final String tawkSrc;

  DashboardAuthorModel({
    required this.readersCount,
    required this.topReaders,
    required this.myBooks,
    required this.pendingBooks,
    required this.declineBooks,
    required this.user,
    required this.unreadNotificationCount,
    required this.tawkSrc,
  });

  factory DashboardAuthorModel.fromJson(String str) =>
      DashboardAuthorModel.fromMap(json.decode(str));

  String toJson() => json.encode(toJson());

  factory DashboardAuthorModel.fromMap(Map<String, dynamic> json) =>
      DashboardAuthorModel(
        readersCount: json["readers_count"] ?? 0,
        topReaders: (json["top_readers"] as List<dynamic>?)
                ?.map((x) => TopReader.fromMap(x))
                .toList() ??
            [],
        myBooks: (json["my_books"] as List<dynamic>?)
                ?.map((x) => Book.fromMap(x))
                .toList() ??
            [],
        pendingBooks: (json["pending_books"] as List<dynamic>?)
                ?.map((x) => Book.fromMap(x))
                .toList() ??
            [],
        declineBooks: (json["decline_books"] as List<dynamic>?)
                ?.map((x) => Book.fromMap(x))
                .toList() ??
            [],
        user: UserProfileModel.fromMap(json["user"]),
        unreadNotificationCount: json["unreadNotificationCount"],
        tawkSrc: json["tawk_chat_url"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "readers_count": readersCount,
        "top_readers": List<dynamic>.from(topReaders.map((x) => x.toMap())),
        "my_books": List<dynamic>.from(myBooks.map((x) => x.toMap())),
        "pending_books": List<dynamic>.from(pendingBooks.map((x) => x.toMap())),
        "decline_books": List<dynamic>.from(declineBooks.map((x) => x.toMap())),
        "user": user.toJson(),
        "unreadNotificationCount": unreadNotificationCount,
        "tawk_chat_url": tawkSrc,
      };
}

class TopReader {
  final int id;
  final String productId;
  final String userId;
  final String totalView;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String laravelThroughKey;
  final UserProfileModel? user;
  final Book? book;

  TopReader({
    required this.id,
    required this.productId,
    required this.userId,
    required this.totalView,
    required this.createdAt,
    required this.updatedAt,
    required this.laravelThroughKey,
    required this.user,
    required this.book,
  });

  factory TopReader.fromJson(String str) => TopReader.fromMap(json.decode(str));

  String toJson() => json.encode(toJson());

  factory TopReader.fromMap(Map<String, dynamic> json) => TopReader(
        id: json["id"],
        productId: json["product_id"],
        userId: json["user_id"],
        totalView: json["total_view"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        laravelThroughKey: json["laravel_through_key"],
        user: json["user"] == null
            ? null
            : UserProfileModel.fromMap(json["user"]),
        book: json["book"] == null ? null : Book.fromMap(json["book"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "total_view": totalView,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "laravel_through_key": laravelThroughKey,
        "user": user?.toMap(),
        "book": book?.toMap(),
      };
}

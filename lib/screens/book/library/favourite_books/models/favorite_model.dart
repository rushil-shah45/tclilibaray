import 'dart:convert';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';

class FavouriteModel {
  final Books books;
  final int totalBooks;

  FavouriteModel({
    required this.books,
    required this.totalBooks,
  });

  factory FavouriteModel.fromJson(String str) =>
      FavouriteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavouriteModel.fromMap(Map<String, dynamic> json) => FavouriteModel(
        books: Books.fromMap(json["books"]),
        totalBooks: json["total_books"],
      );

  Map<String, dynamic> toMap() => {
        "books": books.toJson(),
        "total_books": totalBooks,
      };
}

class Books {
  final int currentPage;
  final List<Datum> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  Books({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Books.fromJson(String str) => Books.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Books.fromMap(Map<String, dynamic> json) => Books(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"] ?? 0,
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] ?? 0,
        total: json["total"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  final int id;
  final dynamic productId; // Can be either int or string
  final dynamic userId; // Can be either int or string
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic createdBy;
  final Book book;

  Datum({
    required this.id,
    required this.productId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.book,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    productId: json["product_id"] is int
        ? json["product_id"].toString() // Convert int to string if necessary
        : json["product_id"], // Use string as is
    userId: json["user_id"] is int
        ? json["user_id"].toString() // Convert int to string if necessary
        : json["user_id"], // Use string as is
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdBy: json["created_by"],
    book: Book.fromMap(json["book"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId, // Store as is, whether int or string
    "user_id": userId, // Store as is, whether int or string
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "created_by": createdBy,
    "book": book.toMap(),
  };
}



class Link {
  final String url;
  final String label;
  final bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"] ?? "",
        label: json["label"] ?? "",
        active: json["active"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

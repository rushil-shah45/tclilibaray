import 'dart:convert';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';

class AllBookModel {
  final Books books;
  final int totalBooks;

  AllBookModel({
    required this.books,
    required this.totalBooks,
  });

  factory AllBookModel.fromJson(String str) =>
      AllBookModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllBookModel.fromMap(Map<String, dynamic> json) => AllBookModel(
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
  final List<Book> data;
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

  String toJson() => json.encode(toJson());

  factory Books.fromMap(Map<String, dynamic> json) => Books(
        currentPage: json["current_page"],
        data: List<Book>.from(json["data"].map((x) => Book.fromMap(x))),
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
        total: json["total"],
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

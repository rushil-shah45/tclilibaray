import 'dart:convert';
import 'package:tcllibraryapp_develop/screens/setting/model/profile_model.dart';
import 'category_model.dart';

class BooksModel {
  final List<Book> books;
  final int totalBooks;

  BooksModel({
    required this.books,
    required this.totalBooks,
  });

  factory BooksModel.fromJson(String str) =>
      BooksModel.fromMap(json.decode(str));

  String toJson() => json.encode(toJson());

  factory BooksModel.fromMap(Map<String, dynamic> json) => BooksModel(
        books: List<Book>.from(json["books"].map((x) => Book.fromMap(x))),
        totalBooks: json["total_books"],
      );

  Map<String, dynamic> toMap() => {
        "books": List<dynamic>.from(books.map((x) => x.toMap())),
        "total_books": totalBooks,
      };
}

class Book {
  final int id;
  final String code;
  final String title;
  final String subTitle;
  final int categoryId;
  final String slug;
  final int userId;
  final dynamic adminId;
  final String createdAt;
  final String updatedAt;
  final dynamic createdBy;
  final dynamic status;
  final String fileType;
  final String bookFor;
  final String bookPrice;
  final String fileDir;
  final String thumb;
  final String isbn10;
  final String isbn13;
  final String publisher;
  final String size;
  final int pages;
  final String edition;
  final String publisherYear;
  final String description;
  final String readingTime;
  final int isHighlight;
  final int isBookOfMonth;
  final int isPaid;
  final dynamic marcData;
  bool isFavorite;
  bool isBorrowed;
  final dynamic isValid;
  final String borrowedStartdate;
  final String borrowedEnddate;
  final String borrowedNextdate;
  final dynamic isInstitution;
  final String avgRating;
  final int totalReview;
  UserProfileModel? author;
  Category? category;

  Book({
    required this.id,
    required this.code,
    required this.title,
    required this.subTitle,
    required this.categoryId,
    required this.slug,
    required this.userId,
    required this.adminId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.status,
    required this.fileType,
    required this.bookFor,
    required this.bookPrice,
    required this.fileDir,
    required this.thumb,
    required this.isbn10,
    required this.isbn13,
    required this.publisher,
    required this.size,
    required this.pages,
    required this.edition,
    required this.publisherYear,
    required this.description,
    required this.readingTime,
    required this.isHighlight,
    required this.isBookOfMonth,
    required this.isPaid,
    required this.marcData,
    required this.isFavorite,
    required this.isBorrowed,
    required this.isValid,
    required this.borrowedStartdate,
    required this.borrowedEnddate,
    required this.borrowedNextdate,
    required this.isInstitution,
    required this.avgRating,
    required this.totalReview,
    this.author,
    this.category,
  });

  factory Book.fromJson(String str) => Book.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Book.fromMap(Map<String, dynamic> json) => Book(
        id: json["id"] ?? 0,
        code: json["code"] ?? "",
        title: json["title"] ?? "",
        subTitle: json["sub_title"] ?? "",
        categoryId: json["category_id"] is String
            ? int.parse(json["category_id"])
            : json["category_id"] ?? 0,
        slug: json["slug"] ?? "",
        userId: json["user_id"] is String
            ? int.parse(json["user_id"])
            : json["user_id"] ?? 0,
        adminId: json["admin_id"],
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        createdBy: json["created_by"],
        status: json["status"] ?? '',
        fileType: json["file_type"] ?? "",
        bookFor: json["book_for"] ?? "",
        bookPrice: json["book_price"] ?? "",
        fileDir: json["file_dir"] ?? "",
        thumb: json["thumb"] ?? "",
        isbn10: json["isbn10"] ?? "",
        isbn13: json["isbn13"] ?? "",
        publisher: json["publisher"] ?? "",
        size: json["size"] ?? "",
        pages: json["pages"] is String
            ? int.parse(json["pages"])
            : json["pages"] ?? 0,
        edition: json["edition"] ?? "",
        publisherYear: json["publisher_year"] ?? "",
        description: json["description"] ?? "",
        readingTime: json["reading_time"] ?? "",
        isHighlight: json["is_highlight"] is String
            ? int.parse(json["is_highlight"])
            : json["is_highlight"] ?? 0,
        isBookOfMonth: json["is_book_of_month"] is String
            ? int.parse(json["is_book_of_month"])
            : json["is_book_of_month"] ?? 0,
        isPaid: json["is_paid"] is String
            ? int.parse(json["is_paid"])
            : json["is_paid"] ?? 0,
        marcData: json["marc_data"],
        isFavorite: json["is_favorite"] ?? false,
        isBorrowed: json["is_borrowed"] ?? false,
        isValid: json["is_valid"] ?? '',
        borrowedStartdate: json["borrowed_startdate"] ?? '',
        borrowedEnddate: json["borrowed_enddate"] ?? '',
        borrowedNextdate: json["borrowed_nextdate"] ?? '',
        isInstitution: json["is_institution"] ?? '',
        avgRating: json["avg_rating"] ?? '',
        totalReview: json["total_review"] ?? 0,
        author: json["author"] == null
            ? null
            : UserProfileModel.fromMap(json["author"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "title": title,
        "sub_title": subTitle,
        "category_id": categoryId,
        "slug": slug,
        "user_id": userId,
        "admin_id": adminId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "created_by": createdBy,
        "status": status,
        "file_type": fileType,
        "book_for": bookFor,
        "book_price": bookPrice,
        "file_dir": fileDir,
        "thumb": thumb,
        "isbn10": isbn10,
        "isbn13": isbn13,
        "publisher": publisher,
        "size": size,
        "pages": pages,
        "edition": edition,
        "publisher_year": publisherYear,
        "description": description,
        "reading_time": readingTime,
        "is_highlight": isHighlight,
        "is_book_of_month": isBookOfMonth,
        "is_paid": isPaid,
        "marc_data": marcData,
        "is_favorite": isFavorite,
        "is_borrowed": isBorrowed,
        "is_valid": isValid,
        "borrowed_startdate": borrowedStartdate,
        "borrowed_enddate": borrowedEnddate,
        "borrowed_nextdate": borrowedNextdate,
        "is_institution": isInstitution,
        "avg_rating": avgRating,
        "total_review": totalReview,
        "author": author?.toJson(),
        "category": category?.toJson(),
      };
}

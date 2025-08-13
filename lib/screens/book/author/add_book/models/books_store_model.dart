import 'dart:convert';

BookStoreModel bookStoreModelFromJson(String str) =>
    BookStoreModel.fromJson(json.decode(str));

String bookStoreModelToJson(BookStoreModel data) => json.encode(data.toJson());

class BookStoreModel {
  bool status;
  int code;
  String msg;
  String error;
  Data data;
  dynamic description;

  BookStoreModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.error,
    required this.data,
    required this.description,
  });

  factory BookStoreModel.fromJson(Map<String, dynamic> json) => BookStoreModel(
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
  int code;
  String title;
  String subTitle;
  String slug;
  String categoryId;
  int userId;
  int status;
  String fileType;
  String isbn10;
  String isbn13;
  String publisher;
  String size;
  String pages;
  String edition;
  String publisherYear;
  String description;
  String fileDir;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Data({
    required this.code,
    required this.title,
    required this.subTitle,
    required this.slug,
    required this.categoryId,
    required this.userId,
    required this.status,
    required this.fileType,
    required this.isbn10,
    required this.isbn13,
    required this.publisher,
    required this.size,
    required this.pages,
    required this.edition,
    required this.publisherYear,
    required this.description,
    required this.fileDir,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
        title: json["title"],
        subTitle: json["sub_title"],
        slug: json["slug"],
        categoryId: json["category_id"],
        userId: json["user_id"],
        status: json["status"],
        fileType: json["file_type"],
        isbn10: json["isbn10"],
        isbn13: json["isbn13"],
        publisher: json["publisher"],
        size: json["size"],
        pages: json["pages"],
        edition: json["edition"],
        publisherYear: json["publisher_year"],
        description: json["description"],
        fileDir: json["file_dir"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "sub_title": subTitle,
        "slug": slug,
        "category_id": categoryId,
        "user_id": userId,
        "status": status,
        "file_type": fileType,
        "isbn10": isbn10,
        "isbn13": isbn13,
        "publisher": publisher,
        "size": size,
        "pages": pages,
        "edition": edition,
        "publisher_year": publisherYear,
        "description": description,
        "file_dir": fileDir,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

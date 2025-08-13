// To parse this JSON data, do
//
//     final purchasedBookApiResponseData = purchasedBookApiResponseDataFromJson(jsonString);

import 'dart:convert';

PurchasedBookApiResponseData purchasedBookApiResponseDataFromJson(String str) => PurchasedBookApiResponseData.fromJson(json.decode(str));

String purchasedBookApiResponseDataToJson(PurchasedBookApiResponseData data) => json.encode(data.toJson());

class PurchasedBookApiResponseData {
    bool? status;
    int? code;
    String? msg;
    String? error;
    Data? data;
    dynamic description;

    PurchasedBookApiResponseData({
        this.status,
        this.code,
        this.msg,
        this.error,
        this.data,
        this.description,
    });

    factory PurchasedBookApiResponseData.fromJson(Map<String, dynamic> json) => PurchasedBookApiResponseData(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        error: json["error"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "error": error,
        "data": data?.toJson(),
        "description": description,
    };
}

class Data {
    List<PurchasedBookData>? books;
    int? totalBooks;

    Data({
        this.books,
        this.totalBooks,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        books: json["books"] == null ? [] : List<PurchasedBookData>.from(json["books"]!.map((x) => PurchasedBookData.fromJson(x))),
        totalBooks: json["total_books"],
    );

    Map<String, dynamic> toJson() => {
        "books": books == null ? [] : List<dynamic>.from(books!.map((x) => x.toJson())),
        "total_books": totalBooks,
    };
}

class PurchasedBookData {
    int? id;
    String? code;
    String? title;
    dynamic subTitle;
    int? categoryId;
    String? slug;
    int? userId;
    int? adminId;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic createdBy;
    int? status;
    String? fileType;
    String? fileDir;
    String? thumb;
    String? isbn10;
    dynamic isbn13;
    String? publisher;
    String? authors;
    dynamic size;
    dynamic pages;
    dynamic edition;
    String? publisherYear;
    String? description;
    int? isHighlight;
    int? isBookOfMonth;
    int? isPaid;
    String? marcData;
    String? readingTime;
    String? bookFor;
    String? bookPrice;
    String? position;
    int? isValid;
    DateTime? borrowedStartdate;
    String? borrowedEnddate;
    String? borrowedNextdate;
    int? isInstitution;
    bool? isFavorite;
    bool? isBorrowed;
    String? avgRating;
    int? totalReview;

    PurchasedBookData({
        this.id,
        this.code,
        this.title,
        this.subTitle,
        this.categoryId,
        this.slug,
        this.userId,
        this.adminId,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.status,
        this.fileType,
        this.fileDir,
        this.thumb,
        this.isbn10,
        this.isbn13,
        this.publisher,
        this.authors,
        this.size,
        this.pages,
        this.edition,
        this.publisherYear,
        this.description,
        this.isHighlight,
        this.isBookOfMonth,
        this.isPaid,
        this.marcData,
        this.readingTime,
        this.bookFor,
        this.bookPrice,
        this.position,
        this.isValid,
        this.borrowedStartdate,
        this.borrowedEnddate,
        this.borrowedNextdate,
        this.isInstitution,
        this.isFavorite,
        this.isBorrowed,
        this.avgRating,
        this.totalReview,
    });

    factory PurchasedBookData.fromJson(Map<String, dynamic> json) => PurchasedBookData(
        id: json["id"] == null ? null : int.tryParse(json["id"].toString()),
        code: json["code"],
        title: json["title"],
        subTitle: json["sub_title"],
        categoryId: json["category_id"] == null ? null : int.tryParse(json["category_id"].toString()),
        slug: json["slug"],
        userId: json["user_id"] == null ? null : int.tryParse(json["user_id"].toString()),
        adminId: json["admin_id"] == null ? null : int.tryParse(json["admin_id"].toString()),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        status: json["status"] == null ? null : int.tryParse(json["status"].toString()),
        fileType: json["file_type"],
        fileDir: json["file_dir"],
        thumb: json["thumb"],
        isbn10: json["isbn10"],
        isbn13: json["isbn13"],
        publisher: json["publisher"],
        authors: json["authors"],
        size: json["size"],
        pages: json["pages"],
        edition: json["edition"],
        publisherYear: json["publisher_year"],
        description: json["description"],
        isHighlight: json["is_highlight"] == null ? null : int.tryParse(json["is_highlight"].toString()),
        isBookOfMonth: json["is_book_of_month"] == null ? null : int.tryParse(json["is_book_of_month"].toString()),
        isPaid: json["is_paid"] == null ? null : int.tryParse(json["is_paid"].toString()),
        marcData: json["marc_data"],
        readingTime: json["reading_time"],
        bookFor: json["book_for"],
        bookPrice: json["book_price"],
        position: json["position"],
        isValid: json["is_valid"] == null ? null : int.tryParse(json["is_valid"].toString()),
        borrowedStartdate: json["borrowed_startdate"] == null ? null : DateTime.parse(json["borrowed_startdate"]),
        borrowedEnddate: json["borrowed_enddate"],
        borrowedNextdate: json["borrowed_nextdate"],
        isInstitution: json["is_institution"] == null ? null : int.tryParse(json["is_institution"].toString()),
        isFavorite: json["is_favorite"],
        isBorrowed: json["is_borrowed"],
        avgRating: json["avg_rating"],
        totalReview: json["total_review"] == null ? null : int.tryParse(json["total_review"].toString()),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "title": title,
        "sub_title": subTitle,
        "category_id": categoryId,
        "slug": slug,
        "user_id": userId,
        "admin_id": adminId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_by": createdBy,
        "status": status,
        "file_type": fileType,
        "file_dir": fileDir,
        "thumb": thumb,
        "isbn10": isbn10,
        "isbn13": isbn13,
        "publisher": publisher,
        "authors": authors,
        "size": size,
        "pages": pages,
        "edition": edition,
        "publisher_year": publisherYear,
        "description": description,
        "is_highlight": isHighlight,
        "is_book_of_month": isBookOfMonth,
        "is_paid": isPaid,
        "marc_data": marcData,
        "reading_time": readingTime,
        "book_for": bookFor,
        "book_price": bookPrice,
        "position": position,
        "is_valid": isValid,
        "borrowed_startdate": "${borrowedStartdate!.year.toString().padLeft(4, '0')}-${borrowedStartdate!.month.toString().padLeft(2, '0')}-${borrowedStartdate!.day.toString().padLeft(2, '0')}",
        "borrowed_enddate": borrowedEnddate,
        "borrowed_nextdate": borrowedNextdate,
        "is_institution": isInstitution,
        "is_favorite": isFavorite,
        "is_borrowed": isBorrowed,
        "avg_rating": avgRating,
        "total_review": totalReview,
    };
}

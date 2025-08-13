import 'dart:convert';

AllSaleBookResponseModel allSaleBookResponseModelFromJson(String str) => AllSaleBookResponseModel.fromJson(json.decode(str));

String allSaleBookResponseModelToJson(AllSaleBookResponseModel data) => json.encode(data.toJson());

class AllSaleBookResponseModel {
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
    String? size;
    int? pages;
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
    bool? isBorrowed;
    bool? isBorrowedValid;
    bool? isBought;
    String? avgRating;
    int? totalReview;
    String? nextDate;
    bool? isFavorite;
    List<BorrowedBook>? borrowedBooks;
    List<FavouriteBook>? favouriteBooks;

    AllSaleBookResponseModel({
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
        this.isBorrowed,
        this.isBorrowedValid,
        this.isBought,
        this.avgRating,
        this.totalReview,
        this.nextDate,
        this.isFavorite,
        this.borrowedBooks,
        this.favouriteBooks,
    });

    factory AllSaleBookResponseModel.fromJson(Map<String, dynamic> json) => AllSaleBookResponseModel(
        id: int.tryParse(json["id"]?.toString() ?? ''),
        code: json["code"],
        title: json["title"],
        subTitle: json["sub_title"],
        categoryId: int.tryParse(json["category_id"]?.toString() ?? ''),
        slug: json["slug"],
        userId: int.tryParse(json["user_id"]?.toString() ?? ''),
        adminId: int.tryParse(json["admin_id"]?.toString() ?? ''),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        status: int.tryParse(json["status"]?.toString() ?? ''),
        fileType: json["file_type"],
        fileDir: json["file_dir"],
        thumb: json["thumb"],
        isbn10: json["isbn10"],
        isbn13: json["isbn13"],
        publisher: json["publisher"],
        authors: json["authors"],
        size: json["size"],
        pages: int.tryParse(json["pages"]?.toString() ?? ''),
        edition: json["edition"],
        publisherYear: json["publisher_year"],
        description: json["description"],
        isHighlight: int.tryParse(json["is_highlight"]?.toString() ?? ''),
        isBookOfMonth: int.tryParse(json["is_book_of_month"]?.toString() ?? ''),
        isPaid: int.tryParse(json["is_paid"]?.toString() ?? ''),
        marcData: json["marc_data"],
        readingTime: json["reading_time"],
        bookFor: json["book_for"],
        bookPrice: json["book_price"],
        position: json["position"],
        isBorrowed: json["isBorrowed"],
        isBorrowedValid: json["isBorrowedValid"],
        isBought: json["isBought"],
        avgRating: json["avg_rating"],
        totalReview: int.tryParse(json["total_review"]?.toString() ?? ''),
        nextDate: json["next_date"],
        isFavorite: json["isFavorite"],
        borrowedBooks: json["borrowed_books"] == null ? [] : List<BorrowedBook>.from(json["borrowed_books"]!.map((x) => BorrowedBook.fromJson(x))),
        favouriteBooks: json["favourite_books"] == null ? [] : List<FavouriteBook>.from(json["favourite_books"]!.map((x) => FavouriteBook.fromJson(x))),
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
        "created_at": createdAt,
        "updated_at": updatedAt,
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
        "isBorrowed": isBorrowed,
        "isBorrowedValid": isBorrowedValid,
        "isBought": isBought,
        "next_date": nextDate,
        "isFavorite": isFavorite,
        "borrowed_books": borrowedBooks == null ? [] : List<dynamic>.from(borrowedBooks!.map((x) => x.toJson())),
        "favourite_books": favouriteBooks == null ? [] : List<dynamic>.from(favouriteBooks!.map((x) => x.toJson())),
    };
}

class BorrowedBook {
    int? id;
    int? userId;
    int? productId;
    int? isValid;
    String? borrowedStartdate;
    String? borrowedEnddate;
    String? borrowedNextdate;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? isInstitution;
    int? isStudent;
    dynamic promocodeBookId;
    int? isBought;
    int? promocodeid;

    BorrowedBook({
        this.id,
        this.userId,
        this.productId,
        this.isValid,
        this.borrowedStartdate,
        this.borrowedEnddate,
        this.borrowedNextdate,
        this.createdAt,
        this.updatedAt,
        this.isInstitution,
        this.isStudent,
        this.promocodeBookId,
        this.isBought,
        this.promocodeid,
    });

    factory BorrowedBook.fromJson(Map<String, dynamic> json) => BorrowedBook(
        id: int.tryParse(json["id"]?.toString() ?? ''),
        userId: int.tryParse(json["user_id"]?.toString() ?? ''),
        productId: int.tryParse(json["product_id"]?.toString() ?? ''),
        isValid: int.tryParse(json["is_valid"]?.toString() ?? ''),
        borrowedStartdate: json["borrowed_startdate"],
        borrowedEnddate: json["borrowed_enddate"],
        borrowedNextdate: json["borrowed_nextdate"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isInstitution: int.tryParse(json["is_institution"]?.toString() ?? ''),
        isStudent: int.tryParse(json["is_student"]?.toString() ?? ''),
        promocodeBookId: json["promocode_book_id"],
        isBought: int.tryParse(json["is_bought"]?.toString() ?? ''),
        promocodeid: int.tryParse(json["promocodeid"]?.toString() ?? ''),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "is_valid": isValid,
        "borrowed_startdate": borrowedStartdate,
        "borrowed_enddate": borrowedEnddate,
        "borrowed_nextdate": borrowedNextdate,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_institution": isInstitution,
        "is_student": isStudent,
        "promocode_book_id": promocodeBookId,
        "is_bought": isBought,
        "promocodeid": promocodeid,
    };
}

class FavouriteBook {
    int? id;
    int? productId;
    int? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic createdBy;

    FavouriteBook({
        this.id,
        this.productId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
    });

    factory FavouriteBook.fromJson(Map<String, dynamic> json) => FavouriteBook(
        id: int.tryParse(json["id"]?.toString() ?? ''),
        productId: int.tryParse(json["product_id"]?.toString() ?? ''),
        userId: int.tryParse(json["user_id"]?.toString() ?? ''),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "created_by": createdBy,
    };
}

import 'dart:convert';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/model/profile_model.dart';

class DashboardUserModel {
  final List<LastViewedBook> lastViewedBooks;
  final List<LastBorrowedBook> lastBorrowedBooks;
  final int totalViewedBooks;
  final int totalBorrowedBooks;
  final int subscriptionRemaining;
  final UserProfileModel user;
  final Plan plan;
  final int unreadNotificationCount;
  final String tawkSrc;

  DashboardUserModel({
    required this.lastViewedBooks,
    required this.lastBorrowedBooks,
    required this.totalViewedBooks,
    required this.totalBorrowedBooks,
    required this.subscriptionRemaining,
    required this.user,
    required this.plan,
    required this.unreadNotificationCount,
    required this.tawkSrc,
  });

  factory DashboardUserModel.fromJson(String str) =>
      DashboardUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toJson());

  factory DashboardUserModel.fromMap(Map<String, dynamic> json) =>
      DashboardUserModel(
        lastViewedBooks: (json["last_viewed_books"] as List<dynamic>?)
                ?.map((x) => LastViewedBook.fromMap(x))
                .toList() ??
            [],
        lastBorrowedBooks: (json["last_borrowed_books"] as List<dynamic>?)
                ?.map((x) => LastBorrowedBook.fromMap(x))
                .toList() ??
            [],
        totalViewedBooks: json["total_viewed_books"] ?? 0,
        totalBorrowedBooks: json["total_borrowed_books"] ?? 0,
        subscriptionRemaining: json["subscription_remaining"] ?? 0,
        user: UserProfileModel.fromMap(json["user"]),
        plan: json["plan"] != null && json["plan"] is Map<String, dynamic>
            ? Plan.fromJson(json["plan"])
            : Plan(
                id: 0,
                title: "",
                status: "",
                price: "",
                priceNgn: "",
                duration: "",
                offerings: "",
                planLibrary: "",
                book: "",
                blog: "",
                forum: "",
                club: "",
                createdBy: "",
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                planId: null,
                planId2: null,
                paypalPlanData: null,
                flutterwavePlanData: null),
        unreadNotificationCount: json["unreadNotificationCount"],
        tawkSrc: json["tawk_chat_url"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "last_viewed_books":
            List<dynamic>.from(lastViewedBooks.map((x) => x.toMap())),
        "last_borrowed_books":
            List<dynamic>.from(lastBorrowedBooks.map((x) => x.toMap())),
        "total_viewed_books": totalViewedBooks,
        "total_borrowed_books": totalBorrowedBooks,
        "subscription_remaining": subscriptionRemaining,
        "user": user.toJson(),
        "plan": plan.toJson(),
        "unreadNotificationCount": unreadNotificationCount,
        "tawk_chat_url": tawkSrc,
      };
}

class LastViewedBook {
  final int id;
  final dynamic productId; // Can be int or String
  final dynamic userId; // Can be int or String
  final dynamic totalView; // Can be int or String
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

  String toJson() => json.encode(toMap());

  factory LastViewedBook.fromMap(Map<String, dynamic> json) => LastViewedBook(
    id: json["id"] ?? 0,
    productId: json["product_id"], // No need to cast, handle as dynamic
    userId: json["user_id"], // Can be int or String
    totalView: json["total_view"], // Can be int or String
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    book: json["book"] == null ? null : Book.fromMap(json["book"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId.toString(), // Ensure it's serialized as a string
    "user_id": userId.toString(), // Ensure userId is serialized as a string
    "total_view": totalView.toString(), // Ensure totalView is serialized as a string
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "book": book?.toMap(),
  };
}

class LastBorrowedBook {
  final int id;
  final dynamic userId; // Can be int or String
  final dynamic productId; // Can be int or String
  final dynamic isValid; // Can be int or String
  final DateTime? borrowedStartdate;
  final DateTime? borrowedEnddate;
  final DateTime? borrowedNextdate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic isInstitution; // Can be int or String
  final dynamic promocodeBookId;
  final Book? book;

  LastBorrowedBook({
    required this.id,
    required this.userId,
    required this.productId,
    required this.isValid,
    this.borrowedStartdate,
    this.borrowedEnddate,
    this.borrowedNextdate,
    this.createdAt,
    this.updatedAt,
    required this.isInstitution,
    required this.promocodeBookId,
    required this.book,
  });

  factory LastBorrowedBook.fromJson(String str) =>
      LastBorrowedBook.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LastBorrowedBook.fromMap(Map<String, dynamic> json) => LastBorrowedBook(
    id: json["id"] ?? 0,
    userId: json["user_id"], // Can be int or String
    productId: json["product_id"], // Can be int or String
    isValid: json["is_valid"], // Can be int or String
    borrowedStartdate: (json["borrowed_startdate"] != null && json["borrowed_startdate"] != "")
        ? DateTime.tryParse("${json["borrowed_startdate"]}")
        : null,
    borrowedEnddate: (json["borrowed_enddate"] != null && json["borrowed_enddate"] != "")
        ? DateTime.tryParse("${json["borrowed_enddate"]}")
        : null,
    borrowedNextdate: (json["borrowed_nextdate"] != null && json["borrowed_nextdate"] != "")
        ? DateTime.tryParse("${json["borrowed_nextdate"]}")
        : null,
    createdAt: (json["created_at"] != null && json["created_at"] != "")
        ? DateTime.tryParse("${json["created_at"]}")
        : null,
    updatedAt: (json["updated_at"] != null && json["updated_at"] != "")
        ? DateTime.tryParse("${json["updated_at"]}")
        : null,
    isInstitution: json["is_institution"], // Can be int or String
    promocodeBookId: json["promocode_book_id"],
    book: json["book"] == null ? null : Book.fromMap(json["book"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId.toString(), // Ensure userId is serialized as a string
    "product_id": productId.toString(), // Ensure productId is serialized as a string
    "is_valid": isValid.toString(), // Ensure isValid is serialized as a string
    "borrowed_startdate": borrowedStartdate != null
        ? "${borrowedStartdate!.year.toString().padLeft(4, '0')}-${borrowedStartdate!.month.toString().padLeft(2, '0')}-${borrowedStartdate!.day.toString().padLeft(2, '0')}"
        : null,
    "borrowed_enddate": borrowedEnddate != null
        ? "${borrowedEnddate!.year.toString().padLeft(4, '0')}-${borrowedEnddate!.month.toString().padLeft(2, '0')}-${borrowedEnddate!.day.toString().padLeft(2, '0')}"
        : null,
    "borrowed_nextdate": borrowedNextdate != null
        ? "${borrowedNextdate!.year.toString().padLeft(4, '0')}-${borrowedNextdate!.month.toString().padLeft(2, '0')}-${borrowedNextdate!.day.toString().padLeft(2, '0')}"
        : null,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_institution": isInstitution.toString(), // Ensure isInstitution is serialized as a string
    "promocode_book_id": promocodeBookId,
    "book": book?.toMap(),
  };
}

class Plan {
  int id;
  String title;
  dynamic status; // Can be int or String
  dynamic price; // Can be int or String
  dynamic priceNgn; // Can be int or String
  dynamic duration; // Can be int or String
  dynamic offerings; // Can be int or String
  dynamic planLibrary; // Can be int or String
  dynamic book; // Can be int or String
  dynamic blog; // Can be int or String
  dynamic forum; // Can be int or String
  dynamic club; // Can be int or String
  dynamic createdBy; // Updated to dynamic, can be int or String
  DateTime createdAt;
  DateTime updatedAt;
  dynamic planId;
  dynamic planId2;
  dynamic paypalPlanData;
  dynamic flutterwavePlanData;

  Plan({
    required this.id,
    required this.title,
    required this.status,
    required this.price,
    required this.priceNgn,
    required this.duration,
    required this.offerings,
    required this.planLibrary,
    required this.book,
    required this.blog,
    required this.forum,
    required this.club,
    required this.createdBy, // Updated to dynamic
    required this.createdAt,
    required this.updatedAt,
    required this.planId,
    required this.planId2,
    required this.paypalPlanData,
    required this.flutterwavePlanData,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["id"],
    title: json["title"] ?? '',
    status: json["status"], // Can be int or String
    price: json["price"], // Can be int or String
    priceNgn: json["price_ngn"], // Can be int or String
    duration: json["duration"], // Can be int or String
    offerings: json["offerings"], // Can be int or String
    planLibrary: json["library"], // Can be int or String
    book: json["book"], // Can be int or String
    blog: json["blog"], // Can be int or String
    forum: json["forum"], // Can be int or String
    club: json["club"], // Can be int or String
    createdBy: json["created_by"], // Updated to dynamic
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    planId: json["plan_id"],
    planId2: json["plan_id2"],
    paypalPlanData: json["paypal_plan_data"],
    flutterwavePlanData: json["flutterwave_plan_data"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status.toString(), // Convert to string for consistency
    "price": price.toString(), // Convert to string for consistency
    "price_ngn": priceNgn.toString(), // Convert to string for consistency
    "duration": duration.toString(), // Convert to string for consistency
    "offerings": offerings.toString(), // Convert to string for consistency
    "library": planLibrary.toString(), // Convert to string for consistency
    "book": book.toString(), // Convert to string for consistency
    "blog": blog.toString(), // Convert to string for consistency
    "forum": forum.toString(), // Convert to string for consistency
    "club": club.toString(), // Convert to string for consistency
    "created_by": createdBy.toString(), // Convert to string for consistency
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "plan_id": planId,
    "plan_id2": planId2,
    "paypal_plan_data": paypalPlanData,
    "flutterwave_plan_data": flutterwavePlanData,
  };
}












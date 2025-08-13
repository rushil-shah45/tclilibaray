// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

List<TransactionModel> transactionModelFromJson(String str) => List<TransactionModel>.from(json.decode(str).map((x) => TransactionModel.fromJson(x)));

String transactionModelToJson(List<TransactionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionModel {
  int id;
  String transactionId;
  String paymentProvider;
  dynamic packageId;
  dynamic userId;
  dynamic userPlanId;
  String amount;
  String currencySymbol;
  String usdAmount;
  String billingData;
  String paymentStatus;
  DateTime createdAt;
  DateTime updatedAt;
  BookTransitionModel? book;

  TransactionModel({
    required this.id,
    required this.transactionId,
    required this.paymentProvider,
    required this.packageId,
    required this.userId,
    required this.userPlanId,
    required this.amount,
    required this.currencySymbol,
    required this.usdAmount,
    required this.billingData,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    this.book,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        id: json["id"] != null ? json["id"] : null,
        transactionId: json["transaction_id"] != null ? json["transaction_id"] : "",
        paymentProvider: json["payment_provider"] != null ? json["payment_provider"] : "",
        packageId: json["package_id"] != null
            ? json["package_id"] is int
                ? json["package_id"].toString()
                : json["package_id"] ?? ""
            : null,
        userId: json["user_id"] != null
            ? json["user_id"] is int
                ? json["user_id"].toString()
                : json["user_id"] ?? ""
            : null, // Handle userId
        userPlanId: json["user_plan_id"] != null
            ? json["user_plan_id"] is int
                ? json["user_plan_id"].toString()
                : json["user_plan_id"] ?? ""
            : null, // Handle userPlanId
        amount: json["amount"] == null ? "" : json["amount"].toString(),
        currencySymbol: json["currency_symbol"] != null ? json["currency_symbol"] : null,
        usdAmount: json["usd_amount"] != null ? json["usd_amount"] : "",
        billingData: json["billing_data"] != null ? json["billing_data"] : "",
        paymentStatus: json["payment_status"] != null ? json["payment_status"] : "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        book: json["book"] == null ? null : BookTransitionModel.fromJson(json["book"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "payment_provider": paymentProvider,
        "package_id": packageId,
        "user_id": userId,
        "user_plan_id": userPlanId,
        "amount": amount,
        "currency_symbol": currencySymbol,
        "usd_amount": usdAmount,
        "billing_data": billingData,
        "payment_status": paymentStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "book": book?.toJson(),
      };
}

class BookTransitionModel {
  // int id;
  // String code;
  String title;
  // String slug;

  BookTransitionModel({
    // required this.id,
    // required this.code,
    required this.title,
    // required this.slug,
  });

  factory BookTransitionModel.fromJson(Map<String, dynamic> json) => BookTransitionModel(
        // id: json["id"],
        // code: json["code"],
        title: json["title"],
        // slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        // "code": code,
        "title": title,
        // "slug": slug,
      };
}

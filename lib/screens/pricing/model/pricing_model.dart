import 'dart:convert';

List<PricingModel> pricingModelFromJson(String str) => List<PricingModel>.from(
    json.decode(str).map((x) => PricingModel.fromJson(x)));

String pricingModelToJson(List<PricingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PricingModel {
  int id;
  String title;
  dynamic price; // Handle both int and String
  dynamic priceNgn; // Handle both int and String
  dynamic duration; // Updated to dynamic to handle both int and String
  bool isSubscribed;
  String paypalPlan;
  String flutterPlan;
  String offerings;
  String pricingModelLibrary;
  String book;
  String blog;
  String forum;
  String club;

  PricingModel({
    required this.id,
    required this.title,
    required this.price, // Handle both int and String
    required this.priceNgn, // Handle both int and String
    required this.duration, // Handle both int and String
    required this.isSubscribed,
    required this.paypalPlan,
    required this.flutterPlan,
    required this.offerings,
    required this.pricingModelLibrary,
    required this.book,
    required this.blog,
    required this.forum,
    required this.club,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) => PricingModel(
    id: json["id"],
    title: json["title"],
    price: json["price"] is int ? json["price"].toString() : json["price"], // Handle price
    priceNgn: json["price_ngn"] is int ? json["price_ngn"].toString() : json["price_ngn"], // Handle price_ngn
    duration: json["duration"] is int ? json["duration"].toString() : json["duration"], // Handle duration
    isSubscribed: json["is_subscribed"] ?? false,
    paypalPlan: json["paypalPlan"] ?? '',
    flutterPlan: json["flutterPlan"] ?? '',
    offerings: json["offerings"],
    pricingModelLibrary: json["library"],
    book: json["book"],
    blog: json["blog"],
    forum: json["forum"],
    club: json["club"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price, // Keep as dynamic for consistency
    "price_ngn": priceNgn, // Keep as dynamic for consistency
    "duration": duration, // Keep as dynamic for consistency
    "is_subscribed": isSubscribed,
    "paypalPlan": paypalPlan,
    "flutterPlan": flutterPlan,
    "offerings": offerings,
    "library": pricingModelLibrary,
    "book": book,
    "blog": blog,
    "forum": forum,
    "club": club,
  };
}





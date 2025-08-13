import 'dart:convert';

class PricingModel {
  final int id;
  final String title;
  final String price;
  final String priceNgn;
  final String duration;
  final String offerings;
  final String pricingModelLibrary;
  final String book;
  final String blog;
  final String forum;
  final String club;

  PricingModel({
    required this.id,
    required this.title,
    required this.price,
    required this.priceNgn,
    required this.duration,
    required this.offerings,
    required this.pricingModelLibrary,
    required this.book,
    required this.blog,
    required this.forum,
    required this.club,
  });

  factory PricingModel.fromJson(String str) => PricingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PricingModel.fromMap(Map<String, dynamic> json) => PricingModel(
    id: json["id"]??0,
    title: json["title"]??"",
    price: json["price"]??"",
    priceNgn: json["price_ngn"]??"",
    duration: json["duration"]??"",
    offerings: json["offerings"]??"",
    pricingModelLibrary: json["library"]??"",
    book: json["book"]??"",
    blog: json["blog"]??"",
    forum: json["forum"]??"",
    club: json["club"]??"",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "price": price,
    "price_ngn": priceNgn,
    "duration": duration,
    "offerings": offerings,
    "library": pricingModelLibrary,
    "book": book,
    "blog": blog,
    "forum": forum,
    "club": club,
  };
}

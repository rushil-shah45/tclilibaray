import 'dart:convert';

class CustomPageModel {
  final int id;
  final String title;
  final String urlSlug;
  final String body;
  final int isActive;
  final int orderId;
  final dynamic metaKeywords;
  final dynamic metaDescription;
  final dynamic updateBy;
  final int createdBy;
  final String createdAt;
  final String updatedAt;
  final dynamic position;
  final int updatedBy;
  final dynamic displayIn;

  CustomPageModel({
    required this.id,
    required this.title,
    required this.urlSlug,
    required this.body,
    required this.isActive,
    required this.orderId,
    required this.metaKeywords,
    required this.metaDescription,
    required this.updateBy,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.position,
    required this.updatedBy,
    required this.displayIn,
  });

  factory CustomPageModel.fromJson(String str) => CustomPageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomPageModel.fromMap(Map<String, dynamic> json) => CustomPageModel(
    id: int.tryParse(json["id"].toString()) ?? 0,
    title: json["title"] ?? "",
    urlSlug: json["url_slug"] ?? "",
    body: json["body"] ?? "",
    isActive: int.tryParse(json["is_active"].toString()) ?? 0,
    orderId: int.tryParse(json["order_id"].toString()) ?? 0,
    metaKeywords: json["meta_keywords"],
    metaDescription: json["meta_description"],
    updateBy: json["update_by"],
    createdBy: int.tryParse(json["created_by"].toString()) ?? 0,
    createdAt: json["created_at"] ?? "",
    updatedAt: json["updated_at"] ?? "",
    position: json["position"],
    updatedBy: int.tryParse(json["updated_by"].toString()) ?? 0,
    displayIn: json["display_in"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "url_slug": urlSlug,
    "body": body,
    "is_active": isActive,
    "order_id": orderId,
    "meta_keywords": metaKeywords,
    "meta_description": metaDescription,
    "update_by": updateBy,
    "created_by": createdBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "position": position,
    "updated_by": updatedBy,
    "display_in": displayIn,
  };
}

import 'dart:convert';

class FaqModel {
  final int id;
  final String title;
  final String body;
  final dynamic isActive;
  final dynamic orderId;
  final dynamic updateBy;
  final dynamic createdBy;
  final String createdAt;
  final String updatedAt;
  final dynamic updatedBy;

  FaqModel({
    required this.id,
    required this.title,
    required this.body,
    required this.isActive,
    required this.orderId,
    required this.updateBy,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory FaqModel.fromJson(String str) => FaqModel.fromMap(json.decode(str));

  String toJson() => json.encode(toJson());

  factory FaqModel.fromMap(Map<String, dynamic> json) => FaqModel(
    id: json["id"],
    title: json["title"]??"",
    body: json["body"]??"",
    isActive: json["is_active"]??"",
    orderId: json["order_id"]??"",
    updateBy: json["update_by"],
    createdBy: json["created_by"]??"",
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    updatedBy: json["updated_by"]??"",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "body": body,
    "is_active": isActive,
    "order_id": orderId,
    "update_by": updateBy,
    "created_by": createdBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "updated_by": updatedBy,
  };
}
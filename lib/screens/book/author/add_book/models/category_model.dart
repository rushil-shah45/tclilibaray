import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  int id;
  String name;
  String slug;
  String logo;
  int orderNumber;
  int status;
  String createdAt;
  String updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.logo,
    required this.orderNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        logo: json["logo"] ?? '',
        orderNumber: json["order_number"] is String ? int.parse(json["order_number"]) : json["order_number"] ?? 0,
        status: json["status"] is String ? int.parse(json["status"]) : json["status"] ?? 0 ,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "logo": logo,
        "order_number": orderNumber,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

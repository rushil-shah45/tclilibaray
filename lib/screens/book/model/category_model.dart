class Category {
  int id;
  String name;
  String slug;
  String logo;
  dynamic orderNumber;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.logo,
    required this.orderNumber,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    logo: json["logo"],
    orderNumber: json["order_number"],
    status: json["status"],
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

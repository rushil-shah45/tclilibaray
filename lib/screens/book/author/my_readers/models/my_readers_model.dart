import 'dart:convert';

MyReadersModel myReadersModelFromJson(String str) =>
    MyReadersModel.fromJson(json.decode(str));

String myReadersModelToJson(MyReadersModel data) => json.encode(data.toJson());

class MyReadersModel {
  final String title;
  final List<Reader> readers;
  final Author author;

  MyReadersModel({
    required this.title,
    required this.readers,
    required this.author,
  });

  factory MyReadersModel.fromJson(Map<String, dynamic> json) => MyReadersModel(
        title: json["title"],
        readers:
            List<Reader>.from(json["readers"].map((x) => Reader.fromJson(x))),
        author: Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "readers": List<dynamic>.from(readers.map((x) => x.toJson())),
        "author": author.toJson(),
      };
}

class Reader {
  final String bookTitle;
  final String bookThumb;
  final String readerFirstName;
  final String readerLastName;
  final String readerEmail;
  final String totalView;
  final DateTime lastViewAt;
  final String laravelThroughKey;

  Reader({
    required this.bookTitle,
    required this.bookThumb,
    required this.readerFirstName,
    required this.readerLastName,
    required this.readerEmail,
    required this.totalView,
    required this.lastViewAt,
    required this.laravelThroughKey,
  });

  factory Reader.fromJson(Map<String, dynamic> json) => Reader(
    bookTitle: json["book_title"] ?? '',
    bookThumb: json["book_thumb"] ?? '',
    readerFirstName: json["reader_first_name"] ?? '',
    readerLastName: json["reader_last_name"] ?? '',
    readerEmail: json["reader_email"] ?? '',
    totalView: json["total_view"] ?? '',
    lastViewAt: DateTime.parse(json["last_view_at"]),
    laravelThroughKey: json["laravel_through_key"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "book_title": bookTitle,
    "book_thumb": bookThumb,
    "reader_first_name": readerFirstName,
    "reader_last_name": readerLastName,
    "reader_email": readerEmail,
    "total_view": totalView,
    "last_view_at": lastViewAt.toIso8601String(),
    "laravel_through_key": laravelThroughKey,
  };
}

class Author {
  final int id;
  final String roleId;
  final String name;
  final String lastName;
  final String email;
  final DateTime emailVerifiedAt;
  final String dialCode;
  final String phone;
  final dynamic address;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final String country;
  final String planId;
  final dynamic billingEmail;
  final dynamic zipcode;
  final dynamic billingName;
  final dynamic billingPhone;
  final dynamic city;
  final dynamic state;
  final dynamic type;

  Author({
    required this.id,
    required this.roleId,
    required this.name,
    required this.lastName,
    required this.email,
    required this.emailVerifiedAt,
    required this.dialCode,
    required this.phone,
    required this.address,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.country,
    required this.planId,
    required this.billingEmail,
    required this.zipcode,
    required this.billingName,
    required this.billingPhone,
    required this.city,
    required this.state,
    required this.type,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"] ?? 0,
        roleId: json["role_id"] ?? '',
        name: json["name"] ?? '',
        lastName: json["last_name"] ?? '',
        email: json["email"] ?? '',
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        dialCode: json["dial_code"] ?? '',
        phone: json["phone"] ?? '',
        address: json["address"] ?? '',
        image: json["image"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"] ?? '',
        country: json["country"] ?? '',
        planId: json["plan_id"],
        billingEmail: json["billing_email"] ?? '',
        zipcode: json["zipcode"] ?? '',
        billingName: json["billing_name"] ?? '',
        billingPhone: json["billing_phone"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        type: json["type"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "dial_code": dialCode,
        "phone": phone,
        "address": address,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "country": country,
        "plan_id": planId,
        "billing_email": billingEmail,
        "zipcode": zipcode,
        "billing_name": billingName,
        "billing_phone": billingPhone,
        "city": city,
        "state": state,
        "type": type,
      };
}
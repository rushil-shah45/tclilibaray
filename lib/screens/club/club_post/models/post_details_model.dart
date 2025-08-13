import 'dart:convert';

PostDetailsModel postDetailsModelFromJson(String str) =>
    PostDetailsModel.fromJson(json.decode(str));

String postDetailsModelToJson(PostDetailsModel data) =>
    json.encode(data.toJson());

class PostDetailsModel {
  int id;
  String clubId;
  String title;
  String slug;
  String status;
  String image;
  String descriptions;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  dynamic updatedBy;
  Club club;
  List<Comment> comments;
  User postUser;

  PostDetailsModel({
    required this.id,
    required this.clubId,
    required this.title,
    required this.slug,
    required this.status,
    required this.image,
    required this.descriptions,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.club,
    required this.comments,
    required this.postUser,
  });

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) =>
      PostDetailsModel(
        id: json["id"],
        clubId: json["club_id"],
        title: json["title"],
        slug: json["slug"],
        status: json["status"],
        image: json["image"],
        descriptions: json["descriptions"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        club: Club.fromJson(json["club"]),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        postUser: User.fromJson(json["post_user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "club_id": clubId,
        "title": title,
        "slug": slug,
        "status": status,
        "image": image,
        "descriptions": descriptions,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "club": club.toJson(),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "post_user": postUser.toJson(),
      };
}

class Club {
  int id;
  String title;
  String status;
  String covarPhoto;
  String profilePhoto;
  String shortDescription;
  String aboutClub;
  String rulesClub;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  String userId;
  String adminId;

  Club({
    required this.id,
    required this.title,
    required this.status,
    required this.covarPhoto,
    required this.profilePhoto,
    required this.shortDescription,
    required this.aboutClub,
    required this.rulesClub,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.userId,
    required this.adminId,
  });

  factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        status: json["status"] ?? '',
        covarPhoto: json["covar_photo"] ?? '',
        profilePhoto: json["profile_photo"] ?? '',
        shortDescription: json["short_description"] ?? '',
        aboutClub: json["about_club"] ?? '',
        rulesClub: json["rules_club"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        userId: json["user_id"] ?? '',
        adminId: json["admin_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "covar_photo": covarPhoto,
        "profile_photo": profilePhoto,
        "short_description": shortDescription,
        "about_club": aboutClub,
        "rules_club": rulesClub,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "user_id": userId,
        "admin_id": adminId,
      };
}

class Comment {
  int id;
  String userId;
  String clubPostId;
  String comments;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  dynamic updatedBy;
  dynamic approvedAt;
  String approvedBy;
  User user;

  Comment({
    required this.id,
    required this.userId,
    required this.clubPostId,
    required this.comments,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.approvedAt,
    required this.approvedBy,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userId: json["user_id"],
        clubPostId: json["club_post_id"],
        comments: json["comments"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        approvedAt: json["approved_at"],
        approvedBy: json["approved_by"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "club_post_id": clubPostId,
        "comments": comments,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "approved_at": approvedAt,
        "approved_by": approvedBy,
        "user": user.toJson(),
      };
}

class User {
  int id;
  String roleId;
  String name;
  String? lastName;
  String email;
  dynamic emailVerifiedAt;
  String? dialCode;
  String? phone;
  dynamic address;
  dynamic image;
  DateTime createdAt;
  DateTime? updatedAt;
  String status;
  String? country;
  String planId;

  User({
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
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        roleId: json["role_id"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        dialCode: json["dial_code"],
        phone: json["phone"],
        address: json["address"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"],
        country: json["country"],
        planId: json["plan_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "dial_code": dialCode,
        "phone": phone,
        "address": address,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "country": country,
        "plan_id": planId,
      };
}

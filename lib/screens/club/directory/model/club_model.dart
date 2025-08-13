import 'dart:convert';

ClubModel clubModelFromJson(String str) => ClubModel.fromJson(json.decode(str));

String clubModelToJson(ClubModel data) => json.encode(data.toJson());

class ClubModel {
  List<Club> allClubs;
  List<Club> myClubs;
  List<Post> posts;
  int postsCount;

  ClubModel({
    required this.allClubs,
    required this.myClubs,
    required this.posts,
    required this.postsCount,
  });

  factory ClubModel.fromJson(Map<String, dynamic> json) => ClubModel(
        allClubs:
            List<Club>.from(json["all_clubs"].map((x) => Club.fromJson(x))),
        myClubs: List<Club>.from(json["my_clubs"].map((x) => Club.fromJson(x))),
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        postsCount: json["posts_count"],
      );

  Map<String, dynamic> toJson() => {
        "all_clubs": List<dynamic>.from(allClubs.map((x) => x.toJson())),
        "my_clubs": List<dynamic>.from(myClubs.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "posts_count": postsCount,
      };
}

class Club {
  int id;
  String title;
  dynamic status; // Can be either int or String
  String covarPhoto;
  String profilePhoto;
  String shortDescription;
  String aboutClub;
  String rulesClub;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic userId; // Can be either int or String
  dynamic adminId; // Can be either int or String
  dynamic membersCount; // Can be either int or String
  bool? isOwner;

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
    required this.membersCount,
    this.isOwner,
  });

  factory Club.fromJson(Map<String, dynamic> json) => Club(
    id: json["id"],
    title: json["title"] ?? '',
    status: json["status"] is int
        ? json["status"].toString()
        : json["status"], // Use string as is
    covarPhoto: json["covar_photo"] ?? '',
    profilePhoto: json["profile_photo"] ?? '',
    shortDescription: json["short_description"] ?? '',
    aboutClub: json["about_club"] ?? '',
    rulesClub: json["rules_club"] ?? '',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    userId: json["user_id"] is int
        ? json["user_id"].toString()
        : json["user_id"],
    adminId: json["admin_id"] is int
        ? json["admin_id"].toString()
        : json["admin_id"],
    membersCount: json["members_count"] is int
        ? json["members_count"].toString()
        : json["members_count"],
    isOwner: json["is_owner"],
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
    "members_count": membersCount,
    "is_owner": isOwner,
  };
}

class Post {
  int id;
  dynamic clubId;
  String title;
  String slug;
  dynamic status;
  String image;
  String descriptions;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic commentsCount;
  User user;
  Club club;

  Post({
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
    required this.commentsCount,
    required this.user,
    required this.club,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    clubId: json["club_id"] is int ? json["club_id"].toString() : json["club_id"],
    title: json["title"],
    slug: json["slug"],
    status: json["status"] is int ? json["status"].toString() : json["status"],
    image: json["image"],
    descriptions: json["descriptions"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdBy: json["created_by"] is int ? json["created_by"].toString() : json["created_by"],
    updatedBy: json["updated_by"],
    commentsCount: json["comments_count"],
    user: User.fromJson(json["user"]),
    club: Club.fromJson(json["club"]),
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
    "comments_count": commentsCount,
    "user": user.toJson(),
    "club": club.toJson(),
  };
}

class User {
  int id;
  dynamic roleId;
  String name;
  String lastName;
  String email;
  dynamic emailVerifiedAt;
  String dialCode;
  String phone;
  dynamic address;
  dynamic image;
  DateTime createdAt;
  dynamic status;
  dynamic country;

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
    required this.status,
    required this.country,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    roleId: json["role_id"] is int ? json["role_id"].toString() : json["role_id"],
    name: json["name"],
    lastName: json["last_name"] ?? '',
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    dialCode: json["dial_code"] ?? '',
    phone: json["phone"] ?? '',
    address: json["address"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    status: json["status"] is int ? json["status"].toString() : json["status"] ?? '',
    country: json["country"] is int ? json["country"].toString() : json["country"] ?? '',
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
    "status": status,
    "country": country,
  };
}




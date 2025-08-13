import 'dart:convert';

ClubDetailsModel clubDetailsModelFromJson(String str) =>
    ClubDetailsModel.fromJson(json.decode(str));

String clubDetailsModelToJson(ClubDetailsModel data) =>
    json.encode(data.toJson());

class ClubDetailsModel {
  Club club;
  List<Member> members;
  int memberCount;
  List<Member> pendingMembers;
  int pendingMembersCount;
  List<Post> posts;
  bool isOwner;
  int flag;
  String flagMessage;

  ClubDetailsModel({
    required this.club,
    required this.members,
    required this.memberCount,
    required this.pendingMembers,
    required this.pendingMembersCount,
    required this.posts,
    required this.isOwner,
    required this.flag,
    required this.flagMessage,
  });

  factory ClubDetailsModel.fromJson(Map<String, dynamic> json) =>
      ClubDetailsModel(
        club: Club.fromJson(json["club"]),
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        memberCount: json["member_count"],
        pendingMembers: List<Member>.from(
            json["pending_members"].map((x) => Member.fromJson(x))),
        pendingMembersCount: json["pending_members_count"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        isOwner: json["is_owner"],
        flag: json["flag"],
        flagMessage: json["flag_message"],
      );

  Map<String, dynamic> toJson() => {
        "club": club.toJson(),
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "member_count": memberCount,
        "pending_members_count": pendingMembersCount,
        "pending_members":
            List<dynamic>.from(pendingMembers.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "is_owner": isOwner,
        "flag": flag,
        "flag_message": flagMessage,
      };
}

class Club {
  int id;
  String title;
  String status;
  String covarPhoto;
  String profilePhoto;
  String shortDescription;
  dynamic aboutClub;
  dynamic rulesClub;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  String userId;
  String adminId;
  ClubAdmin? clubAdmin;

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
    this.clubAdmin,
  });

  factory Club.fromJson(Map<String, dynamic> json) => Club(
      id: json["id"],
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
      clubAdmin: json["club_admin"] == null
          ? null
          : ClubAdmin.fromJson(json["club_admin"]));

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
        "club_admin": clubAdmin?.toJson(),
      };
}

class ClubAdmin {
  int id;
  String name;
  String email;
  DateTime emailVerifiedAt;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  ClubAdmin({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClubAdmin.fromJson(Map<String, dynamic> json) => ClubAdmin(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] != null
            ? DateTime.parse(json["email_verified_at"])
            : DateTime.now(),
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Member {
  int id;
  String clubId;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  dynamic updatedBy;
  dynamic approvedAt;
  dynamic approvedBy;
  String status;
  bool isOwner;
  User user;
  // Club club;

  Member({
    required this.id,
    required this.clubId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.approvedAt,
    required this.approvedBy,
    required this.status,
    required this.isOwner,
    required this.user,
    // required this.club,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        clubId: json["club_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        approvedAt: json["approved_at"],
        approvedBy: json["approved_by"],
        status: json["status"],
        isOwner: json["isOwner"] ?? false,
        user: json["user"] != null
            ? User.fromJson(json["user"])
            : User.fromJson(json["user"]),
        // club: json["club"] != null
        //     ? Club.fromJson(json["club"])
        //     : Club.fromJson(json["club"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "club_id": clubId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "approved_at": approvedAt,
        "approved_by": approvedBy,
        "status": status,
        "isOwner": isOwner,
        "user": user.toJson(),
        // "club": club.toJson(),
      };
}

class User {
  int id;
  String roleId;
  String name;
  String lastName;
  String email;
  DateTime? emailVerifiedAt;
  String dialCode;
  String phone;
  String? address;
  String? image;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  String country;
  String planId;
  dynamic billingEmail;
  dynamic zipcode;
  dynamic billingName;
  dynamic billingPhone;
  dynamic city;
  dynamic state;
  dynamic type;

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
    required this.billingEmail,
    required this.zipcode,
    required this.billingName,
    required this.billingPhone,
    required this.city,
    required this.state,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        roleId: json["role_id"],
        name: json["name"] ?? '',
        lastName: json["last_name"] ?? '',
        email: json["email"] ?? '',
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        dialCode: json["dial_code"],
        phone: json["phone"],
        address: json["address"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        country: json["country"],
        planId: json["plan_id"],
        billingEmail: json["billing_email"],
        zipcode: json["zipcode"],
        billingName: json["billing_name"],
        billingPhone: json["billing_phone"],
        city: json["city"],
        state: json["state"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
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

class Post {
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
  String commentsCount;
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
        commentsCount: json["comments_count"] ?? '0',
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

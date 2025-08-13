import 'dart:convert';

class TicketDetailsModel {
  final int pkNo;
  final String ticketId;
  final int userId;
  final String subject;
  final int priority;
  final dynamic attachement;
  final int seenByAdmin;
  final int seenByUser;
  final int status;
  final int isDeleted;
  final String createdAt;
  final dynamic createdBy;
  final String updatedAt;
  final dynamic updatedBy;
  final List<Details>? details;

  TicketDetailsModel({
    required this.pkNo,
    required this.ticketId,
    required this.userId,
    required this.subject,
    required this.priority,
    required this.attachement,
    required this.seenByAdmin,
    required this.seenByUser,
    required this.status,
    required this.isDeleted,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.details,
  });

  factory TicketDetailsModel.fromJson(String str) =>
      TicketDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketDetailsModel.fromMap(Map<String, dynamic> json) =>
      TicketDetailsModel(
        pkNo: json["pk_no"] ?? 0,
        ticketId: json["ticket_id"] ?? "",
        userId: json["user_id"] is String
            ? int.parse(json["user_id"])
            : json["user_id"] ?? 0,
        subject: json["subject"] ?? "",
        priority: json["priority"] is String
            ? int.parse(json["priority"])
            : json["priority"] ?? 0,
        attachement: json["attachement"],
        seenByAdmin: json["seen_by_admin"] is String
            ? int.parse(json["seen_by_admin"])
            : json["seen_by_admin"] ?? 0,
        seenByUser: json["seen_by_user"] is String
            ? int.parse(json["seen_by_user"])
            : json["seen_by_user"] ?? 0,
        status: json["status"] is String
            ? int.parse(json["status"])
            : json["status"] ?? 0,
        isDeleted: json["is_deleted"] is String
            ? int.parse(json["is_deleted"])
            : json["is_deleted"] ?? 0,
        createdAt: json["created_at"] ?? "",
        createdBy: json["created_by"],
        updatedAt: json["updated_at"] ?? "",
        updatedBy: json["updated_by"],
        details: json["details"] == [] || json["details"] == null
            ? null
            : List<Details>.from(
                json["details"].map((x) => Details.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "pk_no": pkNo,
        "ticket_id": ticketId,
        "user_id": userId,
        "subject": subject,
        "priority": priority,
        "attachement": attachement,
        "seen_by_admin": seenByAdmin,
        "seen_by_user": seenByUser,
        "status": status,
        "is_deleted": isDeleted,
        "created_at": createdAt,
        "created_by": createdBy,
        "updated_at": updatedAt,
        "updated_by": updatedBy,
        "details": List<dynamic>.from(details!.map((x) => x.toMap())),
      };
}

class Details {
  final int id;
  final int ticketId;
  final dynamic fileNameUploaded;
  final String message;
  final int fromUserId;
  final String createdAt;
  final String updatedAt;
  final dynamic attachmentType;
  final int isRead;
  final dynamic adminId;
  final int fromAdmin;
  Admin admin;
  User user;

  Details({
    required this.id,
    required this.ticketId,
    required this.fileNameUploaded,
    required this.message,
    required this.fromUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.attachmentType,
    required this.isRead,
    required this.adminId,
    required this.fromAdmin,
    required this.admin,
    required this.user,
  });

  factory Details.fromJson(String str) => Details.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Details.fromMap(Map<String, dynamic> json) => Details(
        id: json["id"] ?? 0,
        ticketId: json["ticket_id"] is String
            ? int.parse(json["ticket_id"])
            : json["ticket_id"] ?? 0,
        fileNameUploaded: json["file_name_uploaded"],
        message: json["message"] ?? "",
        fromUserId: json["from_user_id"] is String
            ? int.parse(json["from_user_id"])
            : json["from_user_id"] ?? 0,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        attachmentType: json["attachment_type"],
        isRead: json["is_read"] is String
            ? int.parse(json["is_read"])
            : json["is_read"] ?? 0,
        adminId: json["admin_id"],
        fromAdmin: json["from_admin"] is String
            ? int.parse(json["from_admin"])
            : json["from_admin"] ?? 0,
        admin: Admin.fromJson(json["admin"] ?? {}),
        user: User.fromJson(json["user"] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ticket_id": ticketId,
        "file_name_uploaded": fileNameUploaded,
        "message": message,
        "from_user_id": fromUserId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "attachment_type": attachmentType,
        "is_read": isRead,
        "admin_id": adminId,
        "from_admin": fromAdmin,
        "admin": admin.toJson(),
        "user": user.toJson(),
      };
}

class User {
  int id;
  String roleId;
  String name;
  String lastName;
  String email;
  DateTime emailVerifiedAt;
  String dialCode;
  String phone;
  dynamic address;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  String country;
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
        id: json["id"] ?? 0,
        roleId: json["role_id"] ?? '',
        name: json["name"] ?? '',
        lastName: json["last_name"] ?? '',
        email: json["email"] ?? '',
        emailVerifiedAt: DateTime.parse(
            json["email_verified_at"] ?? DateTime.now().toIso8601String()),
        dialCode: json["dial_code"] ?? '',
        phone: json["phone"] ?? '',
        address: json["address"] ?? '',
        image: json["image"] ?? '',
        createdAt: DateTime.parse(
            json["created_at"] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            json["updated_at"] ?? DateTime.now().toIso8601String()),
        status: json["status"] ?? "",
        country: json["country"] ?? "",
        planId: json["plan_id"] ?? "",
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
      };
}

class Admin {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        emailVerifiedAt: DateTime.parse(
            json["email_verified_at"] ?? DateTime.now().toIso8601String()),
        image: json["image"] ?? '',
        createdAt: DateTime.parse(
            json["created_at"] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            json["updated_at"] ?? DateTime.now().toIso8601String()),
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

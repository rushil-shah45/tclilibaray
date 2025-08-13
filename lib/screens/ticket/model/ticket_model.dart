import 'dart:convert';

class TicketModel {
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

  TicketModel({
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
  });

  factory TicketModel.fromJson(String str) => TicketModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketModel.fromMap(Map<String, dynamic> json) => TicketModel(
    pkNo: json["pk_no"]??0,
    ticketId: json["ticket_id"]??"",
    userId: json["user_id"] is String ? int.parse(json["user_id"]) : json["user_id"] ?? 0,
    subject: json["subject"] ??"",
    priority: json["priority"] is String ? int.parse(json["priority"]) : json["priority"] ??0,
    attachement: json["attachement"],
    seenByAdmin: json["seen_by_admin"] is String ? int.parse(json["seen_by_admin"]) : json["seen_by_admin"] ??0,
    seenByUser: json["seen_by_user"] is String ? int.parse(json["seen_by_user"]) : json["seen_by_user"] ??0,
    status: json["status"] is String ? int.parse(json["status"]) : json["status"] ??0,
    isDeleted: json["is_deleted"] is String ? int.parse(json["is_deleted"]) : json["is_deleted"] ??0,
    createdAt: json["created_at"]??"",
    createdBy: json["created_by"],
    updatedAt: json["updated_at"]??"",
    updatedBy: json["updated_by"],
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
  };
}

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  List<Notifications> allNotification;
  int allCount;
  List<Notifications> unreadNotifications;
  int unreadCount;

  NotificationModel({
    required this.allNotification,
    required this.allCount,
    required this.unreadNotifications,
    required this.unreadCount,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        allNotification: List<Notifications>.from(
            json["all_notification"].map((x) => Notifications.fromJson(x))),
        allCount: json["all_count"],
        unreadNotifications: List<Notifications>.from(
            json["unread_notifications"].map((x) => Notifications.fromJson(x))),
        unreadCount: json["unread_count"],
      );

  Map<String, dynamic> toJson() => {
        "all_notification":
            List<dynamic>.from(allNotification.map((x) => x.toJson())),
        "all_count": allCount,
        "unread_notifications":
            List<dynamic>.from(unreadNotifications.map((x) => x.toJson())),
        "unread_count": unreadCount,
      };
}

class Notifications {
  int id;
  String type;
  String title;
  String notifyFor;
  dynamic userId;
  dynamic adminId;
  dynamic isRead;
  String actionRoute;
  DateTime createdAt;
  DateTime updatedAt;
  String url;

  Notifications({
    required this.id,
    required this.type,
    required this.title,
    required this.notifyFor,
    required this.userId,
    required this.adminId,
    required this.isRead,
    required this.actionRoute,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        type: json["type"] ?? '',
        title: json["title"] ?? '',
        notifyFor: json["notify_for"] ?? '',
        userId: json["user_id"] ?? '',
        adminId: json["admin_id"],
        isRead: json["is_read"] ?? '',
        actionRoute: json["action_route"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "notify_for": notifyFor,
        "user_id": userId,
        "admin_id": adminId,
        "is_read": isRead,
        "action_route": actionRoute,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "url": url,
      };
}

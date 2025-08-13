import 'dart:convert';
import 'package:tcllibraryapp_develop/screens/setting/model/profile_model.dart';

class AnalyticsModel {
  int totalBorrowed;
  int totalComplete;
  int totalViewed;
  List<Viewed> viewed;

  AnalyticsModel({
    required this.totalBorrowed,
    required this.totalComplete,
    required this.totalViewed,
    required this.viewed,
  });

  factory AnalyticsModel.fromJson(String str) =>
      AnalyticsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AnalyticsModel.fromMap(Map<String, dynamic> json) => AnalyticsModel(
        totalBorrowed: json["total_borrowed"] ?? 0,
        totalComplete: json["total_complete"] ?? 0,
        totalViewed: json["total_viewed"] ?? 0,
        viewed: List<Viewed>.from(json["viewed"].map((x) => Viewed.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total_borrowed": totalBorrowed,
        "total_complete": totalComplete,
        "total_viewed": totalViewed,
        "viewed": List<dynamic>.from(viewed.map((x) => x.toMap())),
      };
}

class Viewed {
  int id;
  String productId;
  String userId;
  String totalView;
  String progress;
  DateTime createdAt;
  DateTime updatedAt;
  UserProfileModel? userProfileModel;

  Viewed({
    required this.id,
    required this.productId,
    required this.userId,
    required this.totalView,
    required this.progress,
    required this.createdAt,
    required this.updatedAt,
    this.userProfileModel,
  });

  factory Viewed.fromJson(String str) => Viewed.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Viewed.fromMap(Map<String, dynamic> json) => Viewed(
        id: json["id"],
        productId: json["product_id"],
        userId: json["user_id"],
        totalView: json["total_view"] ?? '',
        progress: json["progress"] ?? '0',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userProfileModel: json["user"] != null
            ? UserProfileModel.fromMap(json["user"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "total_view": totalView,
        "progress": progress,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": userProfileModel!.toMap(),
      };
}

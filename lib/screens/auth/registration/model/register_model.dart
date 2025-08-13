import 'dart:convert';
import '../../../setting/model/profile_model.dart';

class UserRegisterModel {
  final String accessToken;
  final String tokenType;
  final int userRole;
  final UserProfileModel user;

  UserRegisterModel({
    required this.accessToken,
    required this.tokenType,
    required this.userRole,
    required this.user,
  });

  factory UserRegisterModel.fromJson(String str) =>
      UserRegisterModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserRegisterModel.fromMap(Map<String, dynamic> json) =>
      UserRegisterModel(
        accessToken: json["access_token"] ?? '',
        tokenType: json["token_type"] ?? '',
        userRole: json["user_role"] is String
            ? int.parse(json["user_role"])
            : json["user_role"] ?? 0,
        user: UserProfileModel.fromMap(json["user"] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "user_role": userRole,
        "user": user.toMap(),
      };
}

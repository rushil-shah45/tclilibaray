// To parse this JSON data, do
//
//     final archivmentApiResponseModel = archivmentApiResponseModelFromJson(jsonString);

import 'dart:convert';

ArchivmentApiResponseModel archivmentApiResponseModelFromJson(String str) => ArchivmentApiResponseModel.fromJson(json.decode(str));

String archivmentApiResponseModelToJson(ArchivmentApiResponseModel data) => json.encode(data.toJson());

class ArchivmentApiResponseModel {
    bool? status;
    int? code;
    String? msg;
    String? error;
    Data? data;
    dynamic description;

    ArchivmentApiResponseModel({
        this.status,
        this.code,
        this.msg,
        this.error,
        this.data,
        this.description,
    });

    factory ArchivmentApiResponseModel.fromJson(Map<String, dynamic> json) => ArchivmentApiResponseModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        error: json["error"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "error": error,
        "data": data?.toJson(),
        "description": description,
    };
}

class Data {
    List<UserAchievement>? userAchievements;
    int? totalBooksRead;
    int? totalPagesRead;

    Data({
        this.userAchievements,
        this.totalBooksRead,
        this.totalPagesRead,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userAchievements: json["userAchievements"] == null ? [] : List<UserAchievement>.from(json["userAchievements"]!.map((x) => UserAchievement.fromJson(x))),
        totalBooksRead: json["totalBooksRead"],
        totalPagesRead: json["totalPagesRead"],
    );

    Map<String, dynamic> toJson() => {
        "userAchievements": userAchievements == null ? [] : List<dynamic>.from(userAchievements!.map((x) => x.toJson())),
        "totalBooksRead": totalBooksRead,
        "totalPagesRead": totalPagesRead,
    };
}

class UserAchievement {
    int? id;
    String? booksread;
    String? name;
    String? pagesread;
    int? status;
    DateTime? createdAt;

    UserAchievement({
        this.id,
        this.booksread,
        this.name,
        this.pagesread,
        this.status,
        this.createdAt,
    });

    factory UserAchievement.fromJson(Map<String, dynamic> json) => UserAchievement(
        id: json["id"] == null ? null : int.tryParse(json["id"].toString()),
        booksread: json["booksread"],
        name: json["name"],
        pagesread: json["pagesread"],
        status: json["status"] == null ? null : int.tryParse(json["status"].toString()),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "booksread": booksread,
        "name": name,
        "pagesread": pagesread,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
    };
}

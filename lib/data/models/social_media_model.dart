import 'dart:convert';

import 'package:equatable/equatable.dart';

class SocialMedias extends Equatable{
  const SocialMedias({
    required this.id,
    required this.socialMedia,
    required this.url,
  });

  final int id;
  final String socialMedia;
  final String url;

  SocialMedias copyWith({
    int? id,
    String? socialMedia,
    String? url,
  }) =>
      SocialMedias(
        id: id ?? this.id,
        socialMedia: socialMedia ?? this.socialMedia,
        url: url ?? this.url,
      );

  factory SocialMedias.fromJson(String str) => SocialMedias.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialMedias.fromMap(Map<String, dynamic> json) => SocialMedias(
    id: json["id"] ?? 0,
    socialMedia: json["social_media"] ?? '',
    url: json["url"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "social_media": socialMedia,
    "url": url,
  };

  @override
  String toString() =>
      'SocialMedias(id: $id, social_media: $socialMedia, url: $url)';

  @override
  List<Object> get props => [id, socialMedia, url];
}
import 'dart:convert';

PublisherAndAuthorModel publisherAndAuthorModelFromJson(String str) =>
    PublisherAndAuthorModel.fromJson(json.decode(str));

String publisherAndAuthorModelToJson(PublisherAndAuthorModel data) =>
    json.encode(data.toJson());

class PublisherAndAuthorModel {
  List<Author> authors;
  List<String> publishers;
  List<CategoryIdModel> categories;

  PublisherAndAuthorModel({
    required this.authors,
    required this.publishers,
    required this.categories,
  });

  factory PublisherAndAuthorModel.fromJson(Map<String, dynamic> json) =>
      PublisherAndAuthorModel(
        authors:
            List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
        publishers: List<String>.from(json["publishers"].map((x) => x)),
        // categories: List<CategoryIdModel>.from(
        //     json["categories"].map((x) => CategoryIdModel.fromJson(json))),
        categories: (json["categories"] as List<dynamic>?)
                ?.map((x) => CategoryIdModel.fromJson(x))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
        "publishers": List<dynamic>.from(publishers.map((x) => x)),
        "categories": List<dynamic>.from(categories.map((x) => x)),
      };
}

class Author {
  int id;
  String name;
  String lastName;

  Author({
    required this.id,
    required this.name,
    required this.lastName,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
      };
}

class CategoryIdModel {
  final int id;
  final String name;

  CategoryIdModel({
    required this.id,
    required this.name,
  });

  factory CategoryIdModel.fromJson(Map<String, dynamic> json) =>
      CategoryIdModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

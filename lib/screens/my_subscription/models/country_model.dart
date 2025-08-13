import 'dart:convert';

List<CountryModel> countryModelFromJson(String str) => List<CountryModel>.from(
    json.decode(str).map((x) => CountryModel.fromJson(x)));

String countryModelToJson(List<CountryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryModel {
  String name;

  CountryModel({
    required this.name,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
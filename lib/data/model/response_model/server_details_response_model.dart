// To parse this JSON data, do
//
//     final serverDetailsResponseModel = serverDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

ServerDetailsResponseModel serverDetailsResponseModelFromJson(String str) => ServerDetailsResponseModel.fromJson(json.decode(str));

String serverDetailsResponseModelToJson(ServerDetailsResponseModel data) => json.encode(data.toJson());

class ServerDetailsResponseModel {
  final dynamic id;
  final dynamic country;
  final dynamic username;
  final dynamic password;
  final dynamic image;
  final dynamic config;
  final dynamic isPremium;
  final dynamic rememberToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ServerDetailsResponseModel({
    this.id,
    this.country,
    this.username,
    this.password,
    this.image,
    this.config,
    this.isPremium,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  factory ServerDetailsResponseModel.fromJson(Map<String, dynamic> json) => ServerDetailsResponseModel(
    id: json["id"],
    country: json["country"],
    username: json["username"],
    password: json["password"],
    image: json["image"],
    config: json["config"],
    isPremium: json["isPremium"],
    rememberToken: json["remember_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country": country,
    "username": username,
    "password": password,
    "image": image,
    "config": config,
    "isPremium": isPremium,
    "remember_token": rememberToken,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

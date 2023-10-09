// To parse this JSON data, do
//
//     final adminProfileResponseModel = adminProfileResponseModelFromJson(jsonString);

import 'dart:convert';

AdminProfileResponseModel adminProfileResponseModelFromJson(String str) => AdminProfileResponseModel.fromJson(json.decode(str));

String adminProfileResponseModelToJson(AdminProfileResponseModel data) => json.encode(data.toJson());

class AdminProfileResponseModel {
  final dynamic id;
  final dynamic name;
  final dynamic email;
  final dynamic emailVerifiedAt;
  final dynamic password;
  final dynamic rememberToken;
  final dynamic createdAt;
  final DateTime? updatedAt;

  AdminProfileResponseModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminProfileResponseModel.fromJson(Map<String, dynamic> json) => AdminProfileResponseModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    password: json["password"],
    rememberToken: json["remember_token"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "password": password,
    "remember_token": rememberToken,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
  };
}

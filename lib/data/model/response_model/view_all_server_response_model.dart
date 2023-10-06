// To parse this JSON data, do
//
//     final viewAllServerResponseModel = viewAllServerResponseModelFromJson(jsonString);

import 'dart:convert';

ViewAllServerResponseModel viewAllServerResponseModelFromJson(String str) => ViewAllServerResponseModel.fromJson(json.decode(str));

String viewAllServerResponseModelToJson(ViewAllServerResponseModel data) => json.encode(data.toJson());

class ViewAllServerResponseModel {
  final dynamic currentPage;
  final List<ViewAllServerData>? allServerList;
  final dynamic firstPageUrl;
  final dynamic from;
  final dynamic lastPage;
  final dynamic lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final dynamic path;
  final dynamic perPage;
  final dynamic prevPageUrl;
  final dynamic to;
  final dynamic total;

  ViewAllServerResponseModel({
    this.currentPage,
    this.allServerList,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory ViewAllServerResponseModel.fromJson(Map<String, dynamic> json) => ViewAllServerResponseModel(
    currentPage: json["current_page"],
    allServerList: json["data"] == null ? [] : List<ViewAllServerData>.from(json["data"]!.map((x) => ViewAllServerData.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": allServerList == null ? [] : List<dynamic>.from(allServerList!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class ViewAllServerData {
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

  ViewAllServerData({
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

  factory ViewAllServerData.fromJson(Map<String, dynamic> json) => ViewAllServerData(
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

class Link {
  final dynamic url;
  final dynamic label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

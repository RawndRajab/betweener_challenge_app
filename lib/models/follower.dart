// To parse this JSON data, do
//
//     final followings = followingsFromJson(jsonString);

import 'dart:convert';

Followings followingsFromJson(String str) => Followings.fromJson(json.decode(str));

String followingsToJson(Followings data) => json.encode(data.toJson());

class Followings {
  int followingCount;
  int followersCount;
  List<Follow> following;
  List<Follow> followers;

  Followings({
    required this.followingCount,
    required this.followersCount,
    required this.following,
    required this.followers,
  });

  factory Followings.fromJson(Map<String, dynamic> json) => Followings(
    followingCount: json["following_count"],
    followersCount: json["followers_count"],
    following: List<Follow>.from(json["following"].map((x) => Follow.fromJson(x))),
    followers: List<Follow>.from(json["followers"].map((x) => Follow.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "following_count": followingCount,
    "followers_count": followersCount,
    "following": List<dynamic>.from(following.map((x) => x.toJson())),
    "followers": List<dynamic>.from(followers.map((x) => x.toJson())),
  };
}

class Follow {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String createdAt;
  String updatedAt;
  int isActive;
  dynamic country;
  dynamic ip;
  dynamic long;
  dynamic lat;

  Follow({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    this.country,
    this.ip,
    this.long,
    this.lat,
  });

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    isActive: json["isActive"],
    country: json["country"],
    ip: json["ip"],
    long: json["long"],
    lat: json["lat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "isActive": isActive,
    "country": country,
    "ip": ip,
    "long": long,
    "lat": lat,
  };
}

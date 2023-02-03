import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel? userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel? data) => json.encode(data!.toJson());

class UserModel {
  UserModel({
    this.id,
    this.fcm,
    this.userId,
    this.username,
    this.imageUrl,
    this.imagePath,
    this.email,
    this.password,
  });

  String? id;
  String? fcm;
  String? userId;
  String? username;
  String? imageUrl;
  String? imagePath;
  String? email;
  String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fcm: json["fcm"],
        userId: json["user_id"],
        username: json["username"],
        imageUrl: json["imageUrl"],
        imagePath: json["imagePath"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "fcm": fcm,
        "username": username,
        "imageUrl": imageUrl,
        "imagePath": imagePath,
        "email": email,
        "password": password,
      };
  factory UserModel.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      UserModel(
        id: json.id,
        userId: json["user_id"],
        fcm: json["fcm"],
        username: json["username"],
        imageUrl: json["imageUrl"],
        imagePath: json["imagePath"],
        email: json["email"],
        password: json["password"],
      );
}

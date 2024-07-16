import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';
import 'package:tennis_court/core/enums/user_type.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  Uint8List picture;
  @HiveField(3)
  UserType userType;
  @HiveField(4)
  String email;
  @HiveField(5)
  String password;
  @HiveField(6)
  int phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.picture,
    required this.userType,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      picture: json['picture'],
      userType: json['userType'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'picture': picture,
      'userType': userType,
      'phoneNumber': phoneNumber,
    };
  }
}

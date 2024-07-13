import 'package:flutter/foundation.dart';
import 'package:tennis_court/core/shared/enums/user_type.dart';

import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  Uint8List picture;
  @HiveField(2)
  UserType userType;
  @HiveField(3)
  String email;
  @HiveField(4)
  String password;
  @HiveField(5)
  int phoneNumber;

  UserModel({
    required this.name,
    required this.picture,
    required this.userType,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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
      'name': name,
      'email': email,
      'password': password,
      'picture': picture,
      'userType': userType,
      'phoneNumber': phoneNumber,
    };
  }

}
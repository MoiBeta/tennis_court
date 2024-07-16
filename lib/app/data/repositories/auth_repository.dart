import 'package:flutter/foundation.dart';
import 'package:tennis_court/app/data/datasources/local/user_local_datasource.dart';
import 'package:tennis_court/app/data/models/user_model.dart';
import 'package:tennis_court/core/enums/user_type.dart';
import 'package:uuid/v1.dart';

class AuthRepository {

  final UserLocalDataSource localDataSource;

  AuthRepository(this.localDataSource);

  Future<UserModel?> registerUser({
    required String name,
    required Uint8List picture,
    required String email,
    required String password,
    required int phoneNumber,
  }) async {
    try {
      UserModel user = UserModel(
        id: const UuidV1().generate(),
        name: name,
        picture: picture,
        userType: UserType.customer,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
      await localDataSource.saveUser(user);
      await localDataSource.saveLoggedInUser(user);
      return user;
    } catch (_) {
      return null;
    }
  }

  Future<UserModel?> loginUser(String email, String password) async {
      final UserModel? user = await localDataSource.getUser(email);
      if (user != null && user.password == password) {
        await localDataSource.saveLoggedInUser(user);
        return user;
      }
      return null;
  }

  Future<void> logoutUser() async {
    try {
      await localDataSource.clearUser();
    } catch (_) {

    }
  }

  Future<UserModel?> getLoggedInUser() {
    return localDataSource.getLoggedInUser();
  }

  List<UserModel> getAllUsers(){
    return localDataSource.getAllUsers() ?? [];
  }

}
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tennis_court/core/error/failures.dart';
import 'package:tennis_court/core/shared/enums/user_type.dart';
import 'package:tennis_court/core/shared/models/user_model.dart';
import 'package:tennis_court/features/authentication/data/datasources/user_local_datasource.dart';
import 'package:tennis_court/features/authentication/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> registerUser({
    required String name,
    required Uint8List picture,
    required String email,
    required String password,
    required int phoneNumber,
  }) async {
    try {
      UserModel user = UserModel(
        name: name,
        picture: picture,
        userType: UserType.customer,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
      await localDataSource.saveUser(user);
      await localDataSource.saveLoggedInUser(user);
      UserModel? userModel = await localDataSource.getLoggedInUser();
      log('The registered usermodel email is: ${userModel?.email}');
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> loginUser(String email, String password) async {
    try {
      final UserModel? user = await localDataSource.getUser(email);
      if (user != null && user.password == password) {
        await localDataSource.saveLoggedInUser(user);
        return const Right(null);
      } else {
        return Left(AuthenticationFailure());
      }
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      final UserModel? user = await localDataSource.getLoggedInUser();
      return user != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, void>> logoutUser() async {
    try {
      await localDataSource.clearUser();
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<UserModel?> getLoggedInUser() {
    return localDataSource.getLoggedInUser();
  }
}
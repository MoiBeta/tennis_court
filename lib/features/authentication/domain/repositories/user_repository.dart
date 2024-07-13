import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tennis_court/core/error/failures.dart';
import 'package:tennis_court/core/shared/models/user_model.dart';

abstract class UserRepository {

  Future<Either<Failure, void>> registerUser({
    required String name,
    required Uint8List picture,
    required String email,
    required String password,
    required int phoneNumber,
  });

  Future<Either<Failure, void>> loginUser(String email, String password);

  Future<Either<Failure, void>> logoutUser();

  Future<bool> isUserLoggedIn();

  Future<UserModel?> getLoggedInUser();
}

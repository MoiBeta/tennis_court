import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tennis_court/core/error/failures.dart';
import 'package:tennis_court/core/usecases/usecase.dart';
import 'package:tennis_court/features/authentication/domain/repositories/user_repository.dart';

class RegisterUserUseCase implements UseCase<void, RegisterParams> {
  final UserRepository repository;

  RegisterUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterParams params) async {
    return await repository.registerUser(
      name: params.name,
      picture: params.picture,
      email: params.email,
      password: params.password,
      phoneNumber: params.phoneNumber,
    );
  }
}

class RegisterParams {
  final String name;
  final Uint8List picture;
  final String email;
  final String password;
  final int phoneNumber;

  RegisterParams({
  required this.name,
  required this.picture,
  required this.email,
  required this.password,
  required this.phoneNumber,
});
}

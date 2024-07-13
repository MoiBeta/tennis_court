import 'package:dartz/dartz.dart';
import 'package:tennis_court/core/error/failures.dart';
import 'package:tennis_court/core/usecases/usecase.dart';
import 'package:tennis_court/features/authentication/domain/repositories/user_repository.dart';

class LoginUserUseCase implements UseCase<void, Params> {
  final UserRepository repository;

  LoginUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.loginUser(params.email, params.password);
  }
}

class Params {
  final String email;
  final String password;

  Params({required this.email, required this.password});
}

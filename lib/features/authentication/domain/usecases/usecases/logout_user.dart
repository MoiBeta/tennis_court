import 'package:dartz/dartz.dart';
import 'package:tennis_court/core/error/failures.dart';
import 'package:tennis_court/core/usecases/usecase.dart';
import 'package:tennis_court/features/authentication/domain/repositories/user_repository.dart';

class LogoutUser implements UseCase<void, NoParams> {
  final UserRepository repository;

  LogoutUser(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logoutUser();
  }
}

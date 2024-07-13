import 'package:dartz/dartz.dart';
import 'package:tennis_court/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
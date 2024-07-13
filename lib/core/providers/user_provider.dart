import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:tennis_court/core/shared/models/user_model.dart';
import 'package:tennis_court/features/authentication/data/repositories/user_repository_impl.dart';
import 'package:tennis_court/features/authentication/domain/repositories/user_repository.dart';
import 'package:tennis_court/features/authentication/domain/usecases/usecases/login_user_usecase.dart';
import 'package:tennis_court/features/authentication/domain/usecases/usecases/register_user_usecase.dart';

import 'package:tennis_court/features/authentication/data/datasources/user_local_datasource.dart';

final userBoxProvider = Provider<Box<UserModel>>((ref) {
  return Hive.box<UserModel>('userBox');
});

final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSource(ref.watch(userBoxProvider));
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(ref.watch(userLocalDataSourceProvider));
});

final userProvider = StateProvider<UserModel?>((ref) => null);

final isUserLoggedInProvider = FutureProvider<bool>((ref) async {
  return ref.watch(userRepositoryProvider).isUserLoggedIn();
});

final registerUserUseCaseProvider = Provider<RegisterUserUseCase>((ref) {
  return RegisterUserUseCase(ref.watch(userRepositoryProvider));
});

final loginUserUseCaseProvider = Provider<LoginUserUseCase>((ref) {
  return LoginUserUseCase(ref.watch(userRepositoryProvider));
});

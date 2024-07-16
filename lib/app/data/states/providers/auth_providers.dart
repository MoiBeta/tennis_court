import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court/app/data/datasources/local/user_local_datasource.dart';
import 'package:tennis_court/app/data/models/user_model.dart';
import 'package:tennis_court/app/data/repositories/auth_repository.dart';
import 'package:tennis_court/app/data/states/providers/loading_provider.dart';

StateNotifierProvider<AuthNotifier, UserModel?> authNotifierProvider =
    StateNotifierProvider(
        (StateNotifierProviderRef<StateNotifier, dynamic> ref) =>
            AuthNotifier(ref));

class AuthNotifier extends StateNotifier<UserModel?> {
  AuthNotifier(this.ref) : super(null);

  StateNotifierProviderRef<StateNotifier, dynamic> ref;

  Future<void> registerUser({
    required String name,
    required Uint8List picture,
    required String email,
    required String password,
    required int phoneNumber,
  }) async {
    try {
      ref.read(loadingProvider.notifier).state = true;
      state = await ref.read(userRepositoryProvider).registerUser(
            name: name,
            picture: picture,
            email: email,
            password: password,
            phoneNumber: phoneNumber,
          );
      ref.read(loadingProvider.notifier).state = false;
    } catch (_) {
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      ref.read(loadingProvider.notifier).state = true;
      state = await ref.read(userRepositoryProvider).loginUser(
        email,
        password,
      );
      ref.read(loadingProvider.notifier).state = false;
    } catch (_) {
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  Future<bool> isUserLoggedIn() async {
    UserModel? user = await ref.read(userRepositoryProvider).getLoggedInUser();
    state = user;
    return user != null;
  }

  Future<void> logoutUser() async {
    ref.read(loadingProvider.notifier).state = true;
    await ref.read(userRepositoryProvider).logoutUser();
    state = null;
    ref.read(loadingProvider.notifier).state = false;
  }

}

final userBoxProvider = Provider<Box<UserModel>>((ref) {
  return Hive.box<UserModel>('userBox');
});

final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSource(ref.watch(userBoxProvider));
});

final userRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(userLocalDataSourceProvider));
});

final userListProvider = Provider((ref)=> ref.read(userRepositoryProvider).getAllUsers());

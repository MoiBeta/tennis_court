import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tennis_court/core/providers/user_provider.dart';
import 'package:tennis_court/core/usecases/usecase.dart';
import 'package:tennis_court/features/authentication/domain/usecases/usecases/logout_user.dart';

final logoutUserUseCaseProvider = Provider<LogoutUser>((ref) {
  return LogoutUser(ref.watch(userRepositoryProvider));
});

class LogoutUserState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  LogoutUserState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
  });

  LogoutUserState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return LogoutUserState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

class LogoutUserNotifier extends StateNotifier<LogoutUserState> {
  final LogoutUser logoutUserUsecase;
  StateNotifierProviderRef<LogoutUserNotifier, LogoutUserState> ref;

  LogoutUserNotifier(
      this.logoutUserUsecase,
      this.ref,
      ) : super(LogoutUserState(isLoading: false, isSuccess: false), );

  Future<void> logoutUser() async {
    state = state.copyWith(isLoading: true);
    final result = await logoutUserUsecase.call(NoParams());
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.toString()),
          (_) {
            ref.read(userProvider.notifier).state = null;
            return state = state.copyWith(isLoading: false, isSuccess: true);
          },
    );
  }
}

final logoutUserNotifierProvider = StateNotifierProvider<LogoutUserNotifier, LogoutUserState>((StateNotifierProviderRef<LogoutUserNotifier, LogoutUserState> ref) {
  return LogoutUserNotifier(ref.watch(logoutUserUseCaseProvider), ref);
});

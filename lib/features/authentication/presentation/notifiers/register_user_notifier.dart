import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennis_court/core/providers/user_provider.dart';
import 'package:tennis_court/features/authentication/domain/usecases/usecases/register_user_usecase.dart';

class RegisterUserState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  RegisterUserState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
  });

  RegisterUserState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return RegisterUserState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

class RegisterUserNotifier extends StateNotifier<RegisterUserState> {
  final RegisterUserUseCase registerUserUsecase;
  final StateNotifierProviderRef<RegisterUserNotifier, RegisterUserState> ref;

  RegisterUserNotifier(
      this.registerUserUsecase,
      this.ref,
      ) : super(
      RegisterUserState(
          isLoading: false,
          isSuccess: false,
      ),
  );

  Future<void> registerUser(RegisterParams params) async {
    state = state.copyWith(isLoading: true);
    final result = await registerUserUsecase.call(params);
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.toString()),
          (_) async {
            ref.read(userProvider.notifier).state = await
            ref.read(userRepositoryProvider).getLoggedInUser();
            return state = state.copyWith(isLoading: false, isSuccess: true);
          },
    );
  }
}

final registerUserNotifierProvider = StateNotifierProvider<RegisterUserNotifier, RegisterUserState>(
        (StateNotifierProviderRef<RegisterUserNotifier, RegisterUserState> ref) {
  return RegisterUserNotifier(ref.watch(registerUserUseCaseProvider), ref);
});

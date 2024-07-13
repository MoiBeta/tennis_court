import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennis_court/core/error/failures.dart';
import 'package:tennis_court/core/navigation/app_routes.dart';
import 'package:tennis_court/core/providers/user_provider.dart';
import 'package:tennis_court/features/authentication/domain/usecases/usecases/login_user_usecase.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu correo electrónico';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu contraseña',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final result =
                        await ref.read(loginUserUseCaseProvider).call(
                              Params(email: email, password: password),
                            );

                    result.fold(
                      (Failure failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Error al iniciar sesión')),
                        );
                      },
                      (success) async {
                        ref.read(userProvider.notifier).state = await
                        ref.read(userRepositoryProvider).getLoggedInUser();
                        Navigator.pushReplacementNamed(context, AppRoutes.home);
                      },
                    );
                  }
                },
                child: const Text('Iniciar sesión'),
              ),
              RichText(
                text: TextSpan(
                    text: '¿Aún no tienes una cuenta? ',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Regístrate',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.register);
                          },
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

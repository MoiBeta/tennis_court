import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennis_court/app/data/models/user_model.dart';
import 'package:tennis_court/app/data/states/providers/auth_providers.dart';
import 'package:tennis_court/routes/app_routes.dart';

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
    ref.listen<UserModel?>(authNotifierProvider, (prev, state) {
      if (state != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sesión iniciada correctamente!')),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    });
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
                    await ref.read(authNotifierProvider.notifier).loginUser(
                          email: email,
                          password: password,
                        );

                    if(ref.read(authNotifierProvider) == null){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error iniciando sesión')),
                      );
                    }
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

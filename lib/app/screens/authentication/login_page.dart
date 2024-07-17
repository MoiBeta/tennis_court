import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennis_court/app/data/models/user_model.dart';
import 'package:tennis_court/app/data/states/providers/auth_providers.dart';
import 'package:tennis_court/routes/app_routes.dart';

import 'widgets/icon_textfield.dart';

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
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Column(
          children: [
            Expanded(child: Image.asset('assets/images/background_2.png')),
            const Expanded(
              flex: 2,
                child: SizedBox(),
            ),
          ],
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Container(
              margin: const EdgeInsets.all(10),
              width: 10,
              height: 10,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xFF82BC00),
                borderRadius: BorderRadius.circular(10)
              ),
              child: const Icon(
                  Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: Column(
            children: [
              const Expanded(
                  child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Iniciar sesión',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                IconTextField(
                                  controller: _emailController,
                                  iconName: 'mail',
                                  hintText: 'usuario@email.com',
                                  label: 'Email',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor ingresa tu correo electrónico';
                                    }
                                    return null;
                                  },
                                ),
                                IconTextField(
                                  controller: _passwordController,
                                  iconName: 'lock',
                                  hintText: '************',
                                  label: 'Contraseña',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor ingresa tu contraseña';
                                    }
                                    return null;
                                  },
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: false,
                                        onChanged: (_){},
                                    ),
                                    const Text('Recordar contraseña'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                        '¿Olvidaste tu contraseña?',
                                      style: TextStyle(
                                        color: Color(0xFF346BC3),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 30,
                                      ),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 7,
                                      ),
                                      child: FilledButton(
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
                                        style: Theme.of(context).filledButtonTheme.style
                                            ?.copyWith(
                                          padding: const WidgetStatePropertyAll(
                                            EdgeInsets.symmetric(
                                              vertical: 17,
                                            ),
                                          ),
                                        ),
                                        child: const Text('Iniciar sesión'),
                                      ),
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
                                                color: Color(0xFF346BC3),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

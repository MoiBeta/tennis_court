import 'package:flutter/material.dart';
import 'package:tennis_court/routes/app_routes.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          'assets/images/background.png',
          width: size.width,
          height: size.height,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  bottom: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: size.width / 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                          child: FilledButton(
                              onPressed: (){
                                Navigator.of(context).pushNamed(AppRoutes.login);
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
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                          child: FilledButton(
                            onPressed: (){
                              Navigator.of(context).pushNamed(AppRoutes.register);
                            },
                            style: Theme.of(context).filledButtonTheme.style
                                ?.copyWith(
                              backgroundColor: WidgetStateProperty.all(
                                  Colors.white.withOpacity(0.5),
                              ),
                              padding: const WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                  vertical: 17,
                                ),
                              ),
                            ),
                            child: const Text('Registrarse'),
                          ),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tennis_court/core/navigation/app_routes.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(AppRoutes.login);
                },
                child: const Text('Iniciar sesión'),
            ),
            FilledButton(
              onPressed: (){
                Navigator.of(context).pushNamed(AppRoutes.register);
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}

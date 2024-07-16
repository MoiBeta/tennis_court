import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennis_court/app/data/models/user_model.dart';
import 'package:tennis_court/app/data/states/providers/auth_providers.dart';
import 'package:tennis_court/app/data/states/providers/loading_provider.dart';
import 'package:tennis_court/routes/app_routes.dart';
import 'package:tennis_court/app/screens/authentication/widgets/image_picker_dialog.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? picFile;

  @override
  Widget build(
    BuildContext context,
  ) {
    final bool isLoading = ref.watch(loadingProvider);
    ref.listen<UserModel?>(authNotifierProvider, (prev, state) {
      if (state != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro completado')),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    });
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () async {
                      String path = await showDialog(
                          context: context,
                          builder: (BuildContext ctx) => ImagePickerDialog());

                      setState(() {
                        picFile = File(path);
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: picFile == null
                              ? Image.asset(
                              'assets/images/profile.png',
                            fit: BoxFit.fill,
                          ).image
                              : Image.file(picFile!,
                            fit: BoxFit.fill,
                          ).image,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu nombre',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
              ),
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
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu teléfono',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu número de teléfono';
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
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  hintText: 'Confirma tu contraseña',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor confirma tu contraseña';
                  }
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              FilledButton(
                onPressed: () async {
                  if (picFile != null) {
                    if (_formKey.currentState!.validate()) {
                      final String email = _emailController.text;
                      final String password = _passwordController.text;
                      final String name = _nameController.text;
                      final int phoneNumber =
                          int.parse(_phoneNumberController.text);
                      final Uint8List picture = await picFile!.readAsBytes();
                      await ref
                          .read(authNotifierProvider.notifier)
                          .registerUser(
                            name: name,
                            picture: picture,
                            email: email,
                            password: password,
                            phoneNumber: phoneNumber,
                          );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor agrega una imagen de perfil'),
                      ),
                    );
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Registrarse'),
              ),
              RichText(
                text: TextSpan(
                    text: 'Ya tengo una cuenta, ',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Iniciar sesión',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.login);
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

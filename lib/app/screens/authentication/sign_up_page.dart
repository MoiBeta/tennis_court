import 'dart:developer';
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

import 'widgets/icon_textfield.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<SignUpPage> {
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
          resizeToAvoidBottomInset: false,
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
                flex: 7,
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
                                Center(
                                  child: Stack(
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
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
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
                                            Positioned(
                                              bottom: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: const EdgeInsets.all(3),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      size: 30,
                                                      Icons.add,
                                                      color: Colors.grey,
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
                                const Text(
                                  'Iniciar sesión',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                IconTextField(
                                  controller: _nameController,
                                  hintText: 'Nombre y Apellido',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor ingresa tu nombre';
                                    }
                                    return null;
                                  },
                                  iconName: 'person_2',
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
                                  controller: _phoneNumberController,
                                  iconName: 'phone',
                                  hintText: 'Teléfono',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor ingresa tu número de teléfono';
                                    }
                                    return null;
                                  },
                                  numbersOnly: true,
                                ),
                                IconTextField(
                                  controller: _passwordController,
                                  iconName: 'lock',
                                  hintText: '************',
                                  isPassword: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor ingresa tu contraseña';
                                    }
                                    return null;
                                  },
                                ),
                                IconTextField(
                                  controller: _confirmPasswordController,
                                  iconName: 'lock',
                                  hintText: '************',
                                  isPassword: true,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
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
                                          log('Numero: ${_phoneNumberController.text}');

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
                                        style: Theme.of(context).filledButtonTheme.style
                                            ?.copyWith(
                                          padding: const WidgetStatePropertyAll(
                                            EdgeInsets.symmetric(
                                              vertical: 17,
                                            ),
                                          ),
                                        ),
                                        child: isLoading
                                            ? const CircularProgressIndicator()
                                            : const Text('Registrarse'),
                                      ),
                                    ),  RichText(
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


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennis_court/core/navigation/app_routes.dart';
import 'package:tennis_court/core/navigation/route_generator.dart';
import 'package:tennis_court/core/providers/user_provider.dart';

import 'core/database/hive_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDatabase.init();
  runApp(const ProviderScope(
    child: MyApp(),
  ),);
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

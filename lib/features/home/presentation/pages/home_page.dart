import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennis_court/core/navigation/app_routes.dart';
import 'package:tennis_court/core/providers/user_provider.dart';
import 'package:tennis_court/features/authentication/presentation/notifiers/register_user_notifier.dart';
import 'package:tennis_court/features/home/presentation/notifiers/logout_user_notifier.dart';
import 'package:tennis_court/features/home/presentation/widgets/home_drawer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen<LogoutUserState>(logoutUserNotifierProvider, (prev, state) {
      if (state.isSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.auth,
          (Route<dynamic> route) => false,
        );
      }
    });
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        leading: const SizedBox(),
        title: Text('Hola ${ref.read(userProvider)?.name}'),
      ),
    );
  }
}

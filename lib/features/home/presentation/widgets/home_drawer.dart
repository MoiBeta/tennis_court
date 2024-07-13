import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennis_court/core/navigation/app_routes.dart';
import 'package:tennis_court/features/home/presentation/notifiers/logout_user_notifier.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () async {
              await ref.read(logoutUserNotifierProvider.notifier).logoutUser();
            },
          ),
        ],
      ),
    );
  }
}

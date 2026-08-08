import 'package:flutter/material.dart';
import '../../core/theme/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),

      body: Column(
        children: [
          const SizedBox(height: 15),

          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

          const SizedBox(height: 15),

          Text('Emad Marri', style: Theme.of(context).textTheme.titleLarge),

          Text('emad@example.com', style: Theme.of(context).textTheme.bodySmall),

          const SizedBox(height: 30),

          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Edit Profile'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),

          // زرار التبديل بين الوضع الفاتح والغامق
          ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeController.themeNotifier,
            builder: (context, mode, _) {
              final isDark = mode == ThemeMode.dark;
              return ListTile(
                leading: Icon(
                  isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                ),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: isDark,
                  onChanged: (_) => ThemeController().toggleTheme(),
                ),
                onTap: () => ThemeController().toggleTheme(),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

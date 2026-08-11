import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ql/features/auth/login/login_screen.dart';
import '../../core/theme/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _logout() {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.scale,
        title: 'تسجيل الخروج',
        desc: 'هل انت متاكد من تسجيل الخروج ',
        btnCancelText: "إلغاء",
        btnCancelOnPress: () {},
        btnOkText: "نعم",
        btnOkOnPress: () async {
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn.instance.disconnect();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return LoginScreen();
              },
            ),
          );
        },
      ).show();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),

      body: Column(
        children: [
          SizedBox(height: 15),

          CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

          SizedBox(height: 15),

          Text(
            '${FirebaseAuth.instance.currentUser?.displayName}',
            style: Theme.of(context).textTheme.titleLarge,
          ),

          Text(
            '${FirebaseAuth.instance.currentUser?.email}',
            style: Theme.of(context).textTheme.bodySmall,
          ),

          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Edit Profile'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),

                  ValueListenableBuilder<ThemeMode>(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (context, mode, _) {
                      final isDark = mode == ThemeMode.dark;
                      return ListTile(
                        leading: Icon(
                          isDark
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      _logout();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

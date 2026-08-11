import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ql/features/auth/login/login_screen.dart';
import 'package:ql/features/profile/share_widget_profile.dart';
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

          ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeController.themeNotifier,
            builder: (context, mode, _) {
              final isDark = mode == ThemeMode.dark;
              return ShareWidgetProfile(
                icon1: Icons.person_outline,
                titleList1: 'Edit Profile',
                onTap1: () {},
                icon2: isDark
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                titleList2: 'Dark Mode',
                trailing2: Switch(
                  value: isDark,
                  onChanged: (_) => ThemeController().toggleTheme(),
                ),
                onTap2: () {
                  ThemeController().toggleTheme();
                },
              );
            },
          ),

          ShareWidgetProfile(
            icon1: Icons.logout,
            titleList1: 'Logout',
            onTap1: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }
}

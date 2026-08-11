import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ql/features/auth/login/login_screen.dart';
import 'package:ql/features/profile/share_widget_profile.dart';
import 'package:ql/features/profile/widget_profile/change_password.dart';
import '../../core/theme/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
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
            '${user!.displayName}',
            style: Theme.of(context).textTheme.titleLarge,
          ),

          Text('${user.email}', style: Theme.of(context).textTheme.bodySmall),

          SizedBox(height: 30),

          ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeController.themeNotifier,
            builder: (context, mode, _) {
              final isDark = mode == ThemeMode.dark;
              return ShareWidgetProfile(
                /// list 1
                icon1: Icons.person_outline,
                titleList1: 'Edit Profile',
                trailing1: Icon(Icons.arrow_forward_ios, size: 20),
                onTap1: () {},

                /// list 2
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

                /// list 3
                icon3: Icons.lock_outline,
                titleList3: "Change Password",
                trailing3: Icon(Icons.arrow_forward_ios, size: 20),
                onTap3: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ChangePassword();
                      },
                    ),
                  );
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

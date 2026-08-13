import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:ql/core/l10n/app_localizations.dart';
import 'package:ql/features/auth/login/login_screen.dart';
import 'package:ql/features/profile/share_profile/share_widget_list_tile.dart';
import 'package:ql/features/profile/widget_profile/change_password.dart';
import '../../core/datasource/Preferences_manager/preferences_manager.dart';
import '../../core/provider/provider_controller.dart';
import '../favorite/favorite_controller.dart';
import '../cart/cart_controller.dart';
import '../../core/language/language_controller.dart';
import '../../core/theme/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final t = AppLocalizations.of(context)!;
    void _logout() {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.scale,
        title: t.logoutConfirmTitle,
        desc: t.logoutConfirmDesc,
        btnCancelText: t.cancel,
        btnCancelOnPress: () {},
        btnOkText: t.yes,
        btnOkOnPress: () async {
          Provider.of<ProviderController>(context, listen: false).resetOnLogout();
          Provider.of<FavoriteController>(context, listen: false).resetOnLogout();
          Provider.of<CartController>(context, listen: false).resetOnLogout();

          await FirebaseAuth.instance.signOut();
          await PreferencesManager().clearUserData();
          await GoogleSignIn.instance.disconnect();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
          );
        },
      ).show();
    }

    void _showLanguageDialog() {
      final languageController = Provider.of<LanguageController>(
        context,
        listen: false,
      );
      final t = AppLocalizations.of(context)!;

      showDialog(
        context: context,
        builder: (dialogContext) {
          return  AlertDialog(
            title: Text(t.chooseLanguage),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioGroup<String>(
                  groupValue: languageController.locale.languageCode,
                  onChanged: (value) {
                    if (value != null) {
                      languageController.changeLanguage(value);
                      Navigator.pop(dialogContext);
                    }
                  },
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: Text(t.english),
                        value: 'en',
                      ),

                      RadioListTile<String>(
                        title: Text(t.arabic),
                        value: 'ar',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(t.profileTitle), centerTitle: true),

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
              return Consumer<LanguageController>(
                builder: (context, languageController, _) {
                  final t = AppLocalizations.of(context)!;
                  return ShareWidgetListTile(
                    /// list 1
                    icon1: Icons.person_outline,
                    titleList1: t.editProfile,
                    trailing1: Icon(Icons.arrow_forward_ios, size: 20),
                    onTap1: () {},

                    /// list 2
                    icon2: Icons.language_outlined,
                    titleList2: t.language,
                    trailing2: Text(
                      languageController.isArabic ? t.arabic : t.english,
                    ),
                    onTap2: _showLanguageDialog,

                    /// list 3
                    icon3: isDark
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    titleList3: t.darkMode,
                    trailing3: Switch(
                      value: isDark,
                      onChanged: (_) => ThemeController().toggleTheme(),
                    ),
                    onTap3: () {
                      ThemeController().toggleTheme();
                    },

                    /// list 4
                    icon4: Icons.lock_outline,
                    titleList4: t.changePassword,
                    trailing4: Icon(Icons.arrow_forward_ios, size: 20),
                    onTap4: () {
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
              );
            },
          ),
          ShareWidgetListTile(
            icon1: Icons.logout,
            titleList1: t.logout,
            onTap1: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }
}

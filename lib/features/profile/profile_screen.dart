import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ql/core/l10n/app_localizations.dart';
import 'package:ql/features/profile/profile_controller.dart';
import 'package:ql/features/profile/share_profile/share_widget_list_tile.dart';
import 'package:ql/features/profile/widget_profile/change_password.dart';
import 'package:ql/features/profile/widget_profile/edit_name_bottom_sheet.dart';
import 'package:ql/features/profile/widget_profile/edit_name_controller.dart';
import '../../core/language/language_controller.dart';
import '../../core/theme/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return ChangeNotifierProvider(
      create: (BuildContext context) => ProfileController(),
      child: Consumer<ProfileController>(
        builder: (context, controller, Widget? child) {
          return Scaffold(
            appBar: AppBar(title: Text(t.profileTitle), centerTitle: true),

            body: Column(
              children: [
                SizedBox(height: 15),

                CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

                SizedBox(height: 15),

                ValueListenableBuilder<String?>(
                  valueListenable: EditNameController.displayNameNotifier,
                  builder: (context, displayName, _) {
                    return Text(
                      '${displayName ?? controller.user!.displayName}',
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                  },
                ),

                Text(
                  '${controller.user!.email}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),

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
                          onTap1: () {
                            showEditNameBottomSheet(context);
                          },

                          /// list 2
                          icon2: Icons.language_outlined,
                          titleList2: t.language,
                          trailing2: Text(
                            languageController.isArabic ? t.arabic : t.english,
                          ),
                          onTap2: controller.showLanguageDialog,

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
                    controller.logout();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

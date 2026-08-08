import 'package:flutter/material.dart';
import '../constants/storage_key.dart';
import '../datasource/Preferences_manager/preferences_manager.dart';

/// يتحكم في وضع الثيم (فاتح / غامق) للتطبيق كله،
/// ويحفظ اختيار المستخدم في SharedPreferences عشان يفضل زي ما هو
/// حتى لو المستخدم قفل التطبيق وفتحه تاني.
class ThemeController {
  static final ThemeController _instance = ThemeController._internal();

  factory ThemeController() => _instance;

  ThemeController._internal();

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  void init() {
    final isDark = PreferencesManager().getBool(StorageKey.isDarkMode) ?? false;
    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDarkMode => themeNotifier.value == ThemeMode.dark;

  Future<void> toggleTheme() async {
    final newMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    themeNotifier.value = newMode;
    await PreferencesManager().setBool(
      StorageKey.isDarkMode,
      newMode == ThemeMode.dark,
    );
  }

  Future<void> setTheme(ThemeMode mode) async {
    themeNotifier.value = mode;
    await PreferencesManager().setBool(
      StorageKey.isDarkMode,
      mode == ThemeMode.dark,
    );
  }
}

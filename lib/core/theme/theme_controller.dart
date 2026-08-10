import 'package:flutter/material.dart';

import '../constants/storage_key.dart';
import '../datasource/Preferences_manager/preferences_manager.dart';

class ThemeController {
  static final ThemeController _instance = ThemeController._internal();

  factory ThemeController() => _instance;

  ThemeController._internal();

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  void init() {
    final isDark = PreferencesManager().getBool(StorageKey.isDarkMode) ?? true;

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

    await PreferencesManager().setBool(StorageKey.isDarkMode, mode == ThemeMode.dark,);
  }
}

import 'package:flutter/material.dart';

import '../constants/storage_key.dart';
import '../datasource/Preferences_manager/preferences_manager.dart';

/// Controller مسؤول عن كل منطق تغيير لغة التطبيق (عربي / إنجليزي)
class LanguageController extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  bool get isArabic => _locale.languageCode == 'ar';

  /// يقرأ اللغة المحفوظة في SharedPreferences (لو موجودة) عند تشغيل التطبيق
  void init() {
    final savedLanguageCode = PreferencesManager().getString(
      StorageKey.languageCode,
    );

    _locale = Locale(savedLanguageCode ?? 'en');
  }

  Future<void> changeLanguage(String languageCode) async {
    if (_locale.languageCode == languageCode) return;

    _locale = Locale(languageCode);
    notifyListeners();

    await PreferencesManager().setString(
      StorageKey.languageCode,
      languageCode,
    );
  }

  Future<void> toggleLanguage() async {
    await changeLanguage(isArabic ? 'en' : 'ar');
  }
}

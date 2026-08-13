import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/storage_key.dart';

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();

  factory PreferencesManager() {
    return _instance;
  }

  PreferencesManager._internal();

  late final SharedPreferences _preferences;


  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  bool? getBool(String key){
    return _preferences.getBool(key);
  }
  setBool(String key , bool value)async{
    return await _preferences.setBool(key , value);
  }

  remove(String key) async {
    await _preferences.remove(key);
  }

  Future<bool> clearAll() async {
    return await _preferences.clear();
  }

  Future<void> clearUserData() async {
    final savedLanguage = _preferences.getString(StorageKey.languageCode);
    final savedIsDarkMode = _preferences.getBool(StorageKey.isDarkMode);

    await _preferences.clear();

    if (savedLanguage != null) {
      await _preferences.setString(StorageKey.languageCode, savedLanguage);
    }
    if (savedIsDarkMode != null) {
      await _preferences.setBool(StorageKey.isDarkMode, savedIsDarkMode);
    }
  }
}

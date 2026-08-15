import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../datasource/local/preferences_manager.dart';
import '../../theming/theme_controller.dart';


Future<void> bootstrapApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PreferencesManager().init();
  ThemeController().init();
}
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'core/provider/providers_main_app/app_bootstrap.dart';
import 'core/provider/providers_main_app/app_localization_config.dart';
import 'core/provider/providers_main_app/app_providers.dart';
import 'core/provider/providers_main_app/graphql_setup.dart';
import 'features/splash/splash_screen.dart';
import 'core/language/language_controller.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/theme_controller.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await bootstrapApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key, });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: GraphQLProvider(
        client: GraphqlSetup.client,
        child: Consumer<LanguageController>(
          builder: (context, languageController, _) {
            return ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeController.themeNotifier,
              builder: (context, themeMode, _) {
                return MaterialApp(
                  locale: languageController.locale,
                  supportedLocales: supportedLocales,
                  localizationsDelegates: localizationsDelegates,
                  navigatorKey: navigatorKey,
                  debugShowCheckedModeBanner: false,
                  title: 'QL Shop',
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: themeMode,
                  home: SplashScreen(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
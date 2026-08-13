import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ql/features/splash/splash_screen.dart';
import 'core/datasource/local/preferences_manager.dart';
import 'core/datasource/remote/api_config.dart';
import 'core/l10n/app_localizations.dart';
import 'core/provider/provider_controller.dart';
import 'core/language/language_controller.dart';
import 'features/favorite/favorite_controller.dart';
import 'features/cart/cart_controller.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/theme_controller.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final HttpLink httpLink = HttpLink(ApiConfig.baseUrl);
  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(link: httpLink, cache: GraphQLCache()),
  );
  await PreferencesManager().init();
  ThemeController().init();
  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  const MyApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ProviderController(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FavoriteController(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CartController(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => LanguageController()..init(),
        ),
      ],
      child: GraphQLProvider(
        client: client,
        child: Consumer<LanguageController>(
          builder: (context, languageController, _) {
            return ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeController.themeNotifier,
              builder: (context, themeMode, _) {
                return MaterialApp(
                  locale: languageController.locale,
                  supportedLocales: [
                    Locale('en'), // English
                    Locale('ar'), // Arabic
                  ],
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
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

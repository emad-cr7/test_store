import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ql/features/auth/login/login_screen.dart';
import 'package:ql/main/main_screen.dart';
import 'core/datasource/Preferences_manager/preferences_manager.dart';
import 'core/datasource/api/api_config/api_config.dart';
import 'core/provider/provider_controller.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderController(),
      child: GraphQLProvider(
        client: client,
        child: ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeController.themeNotifier,
          builder: (context, themeMode, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'QL Shop',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              home: MainScreen(),
            );
          },
        ),
      ),
    );
  }
}

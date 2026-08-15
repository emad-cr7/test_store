import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../favorite/favorite_controller.dart';
import '../../../cart/cart_controller.dart';
import '../../../../core/datasource/local/preferences_manager.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/language/language_controller.dart';
import '../../../../core/provider/provider_controller.dart';
import '../../../../main.dart';
import '../../../auth/login/login_screen.dart';

class ProfileController extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;
  void logout() {
    final context = navigatorKey.currentState!.context;
    final t = AppLocalizations.of(context)!;
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

        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false,
        );
      },
    ).show();
  }

  void showLanguageDialog() {
    final context = navigatorKey.currentState!.context;
    final languageController = Provider.of<LanguageController>(
      context,
      listen: false,
    );
    final t = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
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
}
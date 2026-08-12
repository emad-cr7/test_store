import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../favorite/favorite_controller.dart';
import '../../cart/cart_controller.dart';
import '../../../main.dart';
import '../../../main/main_screen.dart';
import '../../../core/l10n/app_localizations.dart';

class LoginController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool obscurePassword = true;
  void showErrorDialog(String message) {
    final context = navigatorKey.currentState!.context;
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: AppLocalizations.of(context)!.error,
      desc: message,
    ).show();
  }

  void togglePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (credential.user!.emailVerified) {
        final context = navigatorKey.currentState!.context;

        final favoriteController = Provider.of<FavoriteController>(
          context,
          listen: false,
        );
        final cartController = Provider.of<CartController>(
          context,
          listen: false,
        );
        await favoriteController.loadFavorites();
        await cartController.loadCart();

        // امسح الـ stack كله وادخل MainScreen من جديد بحالة نضيفة
        navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => MainScreen()),
              (route) => false,
        );
      } else {
        final t = AppLocalizations.of(navigatorKey.currentState!.context)!;
        showErrorDialog(t.pleaseVerifyEmail);
      }
    } on FirebaseAuthException catch (e) {
      final t = AppLocalizations.of(navigatorKey.currentState!.context)!;
      if (e.code == 'invalid-credential') {
        showErrorDialog(t.incorrectCredentials);
      } else if (e.code == 'invalid-email') {
        showErrorDialog(t.invalidEmailAddress);
      } else {
        showErrorDialog(e.message ?? t.somethingWentWrong);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
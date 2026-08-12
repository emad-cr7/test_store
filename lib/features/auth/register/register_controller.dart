import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ql/features/auth/login/login_screen.dart';

import '../../../main.dart';
import '../../../core/l10n/app_localizations.dart';

class RegisterController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  void togglePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }



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

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = credential.user;

      if (user != null) {
        await user.updateDisplayName(
          nameController.text.trim(),
        );

        await user.sendEmailVerification();
      }

      navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      final t = AppLocalizations.of(navigatorKey.currentState!.context)!;
      if (e.code == 'weak-password') {
        showErrorDialog(t.weakPasswordProvided);
      } else if (e.code == 'email-already-in-use') {
        showErrorDialog(t.emailAlreadyInUse);
      } else if (e.code == 'invalid-email') {
        showErrorDialog(t.pleaseEnterValidEmail);
      } else {
        showErrorDialog(e.message ?? t.somethingWentWrong);
      }
    } catch (e) {
      final t = AppLocalizations.of(navigatorKey.currentState!.context)!;
      showErrorDialog(t.somethingWentWrong);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

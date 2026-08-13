import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/share/widgets/custom_snackbar.dart';
import '../../../main.dart';

class ChangePasswordController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    final context = navigatorKey.currentContext;
    final t = context != null ? AppLocalizations.of(context) : null;

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null || user.email == null) {
        throw Exception('User is not logged in');
      }

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPasswordController.text.trim(),
      );

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(
        newPasswordController.text.trim(),
      );

      if (context != null && t != null) {
        AppSnackBar.show(
          context,
          message: t.passwordChangedSuccessfully,
          icon: Icons.check_circle_outline,
          backgroundColor: Colors.green,
        );
      }

      navigatorKey.currentState?.pop();

    } on FirebaseAuthException catch (e) {
      String message = t?.somethingWentWrong ?? 'Something went wrong';

      if (t != null) {
        if (e.code == 'wrong-password' ||
            e.code == 'invalid-credential') {
          message = t.currentPasswordIncorrect;
        } else if (e.code == 'weak-password') {
          message = t.newPasswordTooWeak;
        } else if (e.code == 'requires-recent-login') {
          message = t.pleaseLoginAgainAndTry;
        }
      }

      if (context != null) {
        AppSnackBar.show(
          context,
          message: message,
          icon: Icons.error_outline,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      if (context != null && t != null) {
        AppSnackBar.show(
          context,
          message: t.somethingWentWrong,
          icon: Icons.error_outline,
          backgroundColor: Colors.red,
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleCurrentPassword() {
    obscureCurrentPassword = !obscureCurrentPassword;
    notifyListeners();
  }

  void toggleNewPassword() {
    obscureNewPassword = !obscureNewPassword;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/share_widget/custom_snackbar.dart';
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

      final context = navigatorKey.currentContext;

      if (context != null) {
        AppSnackBar.show(
          context,
          message: 'Password changed successfully',
          icon: Icons.check_circle_outline,
          backgroundColor: Colors.green,
        );
      }

      navigatorKey.currentState?.pop();

    } on FirebaseAuthException catch (e) {
      String message = 'Something went wrong';

      if (e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        message = 'Current password is incorrect';
      } else if (e.code == 'weak-password') {
        message = 'New password is too weak';
      } else if (e.code == 'requires-recent-login') {
        message = 'Please login again and try again';
      }

      final context = navigatorKey.currentContext;

      if (context != null) {
        AppSnackBar.show(
          context,
          message: message,
          icon: Icons.error_outline,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      final context = navigatorKey.currentContext;

      if (context != null) {
        AppSnackBar.show(
          context,
          message: 'Something went wrong',
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
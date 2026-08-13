import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../main.dart';

class ForgetPasswordController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  bool isLoading = false;

  Future<void> forgetPassword() async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    final t = AppLocalizations.of(navigatorKey.currentState!.context)!;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      isLoading = false;
      notifyListeners();

      AwesomeDialog(
        context: navigatorKey.currentState!.context,
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: t.resetLinkSentTitle,
        desc: t.resetLinkSentDesc,
        btnOkOnPress: () {
          final navigator = navigatorKey.currentState!;

          navigator.pop();

          if (navigator.canPop()) {
            navigator.pop();
          }
        },
      ).show();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();

      _showErrorDialog(_mapFirebaseError(e, t));
    } catch (e) {
      isLoading = false;
      notifyListeners();

      _showErrorDialog(t.genericTryAgain);
    }
  }
  String _mapFirebaseError(FirebaseAuthException e, AppLocalizations t) {
    switch (e.code) {
      case 'user-not-found':
        return t.userNotFoundForEmail;
      case 'invalid-email':
        return t.invalidEmailFormat;
      case 'too-many-requests':
        return t.tooManyRequests;
      case 'network-request-failed':
        return t.checkInternetConnection;
      default:
        return t.checkEnteredEmail;
    }
  }

  void _showErrorDialog(String message) {
    final context = navigatorKey.currentState!.context;
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: AppLocalizations.of(context)!.error,
      desc: message,
    ).show();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}

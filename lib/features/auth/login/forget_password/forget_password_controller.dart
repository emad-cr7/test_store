import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ql/features/auth/login/login_screen.dart';

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
        title: 'تم الإرسال',
        desc: 'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.',
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

      _showErrorDialog(_mapFirebaseError(e));
    } catch (e) {
      isLoading = false;
      notifyListeners();

      _showErrorDialog('حدث خطأ، حاول مرة أخرى.');
    }
  }
  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'لا يوجد حساب مرتبط بهذا البريد الإلكتروني.';
      case 'invalid-email':
        return 'صيغة البريد الإلكتروني غير صحيحة.';
      case 'too-many-requests':
        return 'محاولات كثيرة، حاول مرة أخرى بعد قليل.';
      case 'network-request-failed':
        return 'تأكد من اتصالك بالإنترنت وحاول مرة أخرى.';
      default:
        return 'تأكد من البريد الذي قمت بإدخاله.';
    }
  }

  void _showErrorDialog(String message) {
    AwesomeDialog(
      context: navigatorKey.currentState!.context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'خطأ',
      desc: message,
    ).show();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
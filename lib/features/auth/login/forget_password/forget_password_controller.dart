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
          navigatorKey.currentState!.pushReplacement(
            MaterialPageRoute(
              builder: (_) => LoginScreen(),
            ),
          );
        },
      ).show();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();

      if (e.code == 'user-not-found') {
        showErrorDialog('تأكد من البريد الذي قمت بإدخاله.');
      } else if (e.code == 'invalid-email') {
        showErrorDialog('البريد الإلكتروني غير صحيح.');
      } else {
        showErrorDialog(
          e.message ?? 'حدث خطأ، حاول مرة أخرى.',
        );
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();

      showErrorDialog('حدث خطأ، حاول مرة أخرى.');
    }
  }

  void showErrorDialog(String message) {
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
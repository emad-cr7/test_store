import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../main/main_screen.dart';

class LoginController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final  emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool isLoading = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showErrorDialog(String message) {
    AwesomeDialog(
      context: navigatorKey.currentState!.context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'Error',
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
        navigatorKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (_) => MainScreen()),
        );
      } else {
        showErrorDialog('Please verify your email first.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        showErrorDialog('Incorrect email or password.');
      } else if (e.code == 'invalid-email') {
        showErrorDialog('Please enter a valid email address.');
      } else {
        showErrorDialog(e.message ?? 'Something went wrong');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

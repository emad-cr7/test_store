import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ql/features/auth/login/login_screen.dart';

import '../../../main.dart';

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
    AwesomeDialog(
      context: navigatorKey.currentState!.context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'Error',
      desc: message,
    ).show();
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        navigatorKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showErrorDialog("The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          showErrorDialog("The account already exists for that email.");
        }
      } catch (e) {
        print(e);
      }
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

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../favorite/favorite_controller.dart';
import '../../cart/cart_controller.dart';
import '../../../main.dart';
import '../../../main/main_screen.dart';

class LoginController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool obscurePassword = true;
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
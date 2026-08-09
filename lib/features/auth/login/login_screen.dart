import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ql/main/main_screen.dart';
import '../../../core/share_widget/custom_text_formField.dart';
import '../register/register_screen.dart';
import 'forget_password/forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showErrorDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'Error',
      desc: message,
    ).show();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (credential.user!.emailVerified) {
        Navigator.pushReplacement(
          context,
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
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colors.primary.withOpacity(0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 42,
                      color: colors.onPrimary,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  'Welcome Back!',
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Login to continue shopping',
                  style: textTheme.bodySmall?.copyWith(fontSize: 15),
                ),

                const SizedBox(height: 36),

                Text('Email', style: textTheme.labelLarge),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icons.email_outlined,
                  hintText: 'Enter your email',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'من فضلك ادخل الإيميل';
                    if (!value.contains('@')) return 'إيميل غير صحيح';
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Text('Password', style: textTheme.labelLarge),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.lock_outline,
                  hintText: 'Enter your password',
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'من فضلك ادخل الباسورد';
                    if (value.length < 6)
                      return 'الباسورد لازم يكون 6 حروف على الأقل';
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ForgetPasswordScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _login,
                    child: isLoading
                        ? LoadingAnimationWidget.fourRotatingDots(
                            color: Colors.blue,
                            size: 25,
                          )
                        : Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 40),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return RegisterScreen();
                              },
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: colors.secondary,
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

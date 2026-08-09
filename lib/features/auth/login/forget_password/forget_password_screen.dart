import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/share_widget/custom_text_formField.dart';
import '../login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _forget() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim(),
        );
        setState(() {
          isLoading = false;
        });

        AwesomeDialog(
          context: context,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: 'م الارسال',
          desc: 'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.',
          btnOkOnPress: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
        ).show();
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'خطاء',
          desc: 'تاكد من البريد الذي قمت بي ادخاله ',
        ).show();
      }
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
                const SizedBox(height: 10),

                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                ),

                const SizedBox(height: 20),

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
                      Icons.lock_reset_outlined,
                      size: 42,
                      color: colors.onPrimary,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  'Forgot Password?',
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Enter your email and we will send you a link to reset your password',
                  style: textTheme.bodySmall?.copyWith(fontSize: 15),
                ),

                const SizedBox(height: 36),

                Text('Email', style: textTheme.labelLarge),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.email_outlined,
                  hintText: 'Enter your email',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'من فضلك ادخل الإيميل';
                    if (!value.contains('@')) return 'إيميل غير صحيح';
                    return null;
                  },
                ),

                const SizedBox(height: 36),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _forget,
                    child: isLoading
                        ? LoadingAnimationWidget.fourRotatingDots(
                            color: Colors.blue,
                            size: 25,
                          )
                        : Text(
                            'Send Reset Link',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

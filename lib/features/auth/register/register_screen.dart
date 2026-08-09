import 'package:flutter/material.dart';
import '../../../core/share_widget/custom_text_formField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                      Icons.person_add_alt_1_outlined,
                      size: 42,
                      color: colors.onPrimary,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  'Create Account',
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Sign up to start shopping',
                  style: textTheme.bodySmall?.copyWith(fontSize: 15),
                ),

                const SizedBox(height: 36),

                Text('Full Name', style: textTheme.labelLarge),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icons.person_outline,
                  hintText: 'Enter your full name',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'من فضلك ادخل الاسم';
                    if (value.trim().length < 3)
                      return 'الاسم لازم يكون 3 حروف على الأقل';
                    return null;
                  },
                ),

                const SizedBox(height: 20),

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
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icons.lock_outline,
                  hintText: 'Enter your password',
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

                const SizedBox(height: 20),

                Text('Confirm Password', style: textTheme.labelLarge),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.lock_outline,
                  hintText: 'Re-enter your password',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'من فضلك أكّد الباسورد';
                    if (value != _passwordController.text)
                      return 'الباسورد مش متطابق';
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                    ),
                    onPressed: () => setState(
                          () => _obscureConfirmPassword =
                      !_obscureConfirmPassword,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // زرار بألوان الثيم وظل خفيف بدل الشكل الافتراضي المسطح
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // نفّذ عملية التسجيل هنا
                      }
                    },
                    child: const Text(
                      'Register',
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
                        'Already have an account?',
                        style: textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: colors.secondary,
                        ),
                        child: const Text(
                          'Login',
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
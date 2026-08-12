import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:ql/core/l10n/app_localizations.dart';
import 'package:ql/features/auth/login/login_screen.dart';
import 'package:ql/features/auth/register/register_controller.dart';
import '../../../core/share_widget/custom_text_formField.dart';
import '../../../core/share_widget/validators.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;

    return ChangeNotifierProvider(
      create: (BuildContext context) => RegisterController(),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<RegisterController>(
            builder:
                (
                  BuildContext context,
                  RegisterController controller,
                  Widget? child,
                ) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 20,
                    ),
                    child: Form(
                      key: controller.formKey,
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
                            t.createAccount,
                            style: textTheme.titleLarge?.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            t.registerSubtitle,
                            style: textTheme.bodySmall?.copyWith(fontSize: 15),
                          ),

                          const SizedBox(height: 36),

                          Text(t.fullName, style: textTheme.labelLarge),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            controller: controller.nameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            prefixIcon: Icons.person_outline,
                            hintText: t.enterYourFullName,
                            validator: Validators.name,
                          ),

                          const SizedBox(height: 20),

                          Text(t.email, style: textTheme.labelLarge),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            prefixIcon: Icons.email_outlined,
                            hintText: t.enterYourEmail,
                            validator: Validators.email,
                          ),

                          const SizedBox(height: 20),

                          Text(t.password, style: textTheme.labelLarge),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            controller: controller.passwordController,
                            obscureText: controller.obscurePassword,
                            textInputAction: TextInputAction.next,
                            prefixIcon: Icons.lock_outline,
                            hintText: t.enterYourPassword,
                            validator: Validators.password,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                              ),
                              onPressed: controller.togglePassword
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(t.confirmPassword, style: textTheme.labelLarge),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            controller: controller.confirmPasswordController,
                            obscureText: controller.obscureConfirmPassword,
                            textInputAction: TextInputAction.done,
                            prefixIcon: Icons.lock_outline,
                            hintText: t.reEnterYourPassword,
                            validator: (value) => Validators.confirmPassword(
                              value,
                              controller.passwordController.text,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                              ),
                              onPressed: controller.toggleConfirmPassword
                            ),
                          ),

                          const SizedBox(height: 28),

                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: controller.isLoading ? null : controller.register,
                              child: controller.isLoading
                                  ? LoadingAnimationWidget.fourRotatingDots(
                                      color: Colors.blue,
                                      size: 25,
                                    )
                                  : Text(
                                      t.register,
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
                                  t.alreadyHaveAccount,
                                  style: textTheme.bodySmall,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return LoginScreen();
                                        },
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: colors.secondary,
                                  ),
                                  child: Text(
                                    t.login,
                                    style: const TextStyle(
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
                  );
                },
          ),
        ),
      ),
    );
  }
}

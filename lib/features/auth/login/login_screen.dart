import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:ql/core/l10n/app_localizations.dart';
import 'package:ql/core/language/language_controller.dart';
import '../../../core/share_widget/custom_text_formField.dart';
import '../../../core/share_widget/validators.dart';
import '../register/register_screen.dart';
import 'forget_password/forget_password_screen.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginController(),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<LoginController>(
            builder:
                (
                  BuildContext context,
                  LoginController controller,
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

                          Consumer<LanguageController>(
                            builder: (context, languageController, _) {
                              final t = AppLocalizations.of(context)!;
                              return Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: () {
                                    languageController.toggleLanguage();
                                  },
                                  icon: const Icon(Icons.language, size: 18),
                                  label: Text(
                                    languageController.isArabic
                                        ? t.english
                                        : t.arabic,
                                  ),
                                ),
                              );
                            },
                          ),

                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: colors.primary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: colors.primary.withValues(alpha: 0.25),
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
                            AppLocalizations.of(context)!.welcomeBack,
                            style: textTheme.titleLarge?.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            t.loginSubtitle,
                            style: textTheme.bodySmall?.copyWith(fontSize: 15),
                          ),

                          const SizedBox(height: 36),

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
                            textInputAction: TextInputAction.done,
                            prefixIcon: Icons.lock_outline,
                            hintText: t.enterYourPassword,
                            obscureText: controller.obscurePassword,
                            validator: Validators.password,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                              ),
                              onPressed: controller.togglePassword,
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
                              child: Text(
                                t.forgotPassword,
                                style: const TextStyle(
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
                              onPressed: controller.isLoading
                                  ? null
                                  : controller.login,
                              child: controller.isLoading
                                  ? LoadingAnimationWidget.fourRotatingDots(
                                      color: Colors.blue,
                                      size: 25,
                                    )
                                  : Text(
                                      t.login,
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
                                  t.dontHaveAccount,
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
                                  child: Text(
                                    t.signUp,
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

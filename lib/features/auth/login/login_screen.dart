import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:ql/core/l10n/app_localizations.dart';
import 'package:ql/core/language/language_controller.dart';

import '../../../core/share/validators/validators.dart';
import '../../../core/share/widgets/custom_text_formField.dart';
import '../register/register_screen.dart';
import 'forget_password/forget_password_screen.dart';
import 'login_controller.dart';
import '../../../core/theming/app_sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.w26,
                      vertical: AppSizes.ph20,
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppSizes.ph30),

                          Consumer<LanguageController>(
                            builder: (context, languageController, _) {
                              final t = AppLocalizations.of(context)!;
                              return Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: () {
                                    languageController.toggleLanguage();
                                  },
                                  icon: Icon(Icons.language, size: AppSizes.sp18),
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
                              padding: EdgeInsets.all(AppSizes.r20),
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
                                size: AppSizes.sp42,
                                color: colors.onPrimary,
                              ),
                            ),
                          ),

                          SizedBox(height: AppSizes.h32),

                          Text(
                            AppLocalizations.of(context)!.welcomeBack,
                            style: textTheme.titleLarge?.copyWith(
                              fontSize: AppSizes.sp30,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),

                          SizedBox(height: AppSizes.h6),

                          Text(
                            t.loginSubtitle,
                            style: textTheme.bodySmall?.copyWith(fontSize: AppSizes.sp15),
                          ),

                          SizedBox(height: AppSizes.h36),

                          Text(t.email, style: textTheme.labelLarge),
                          SizedBox(height: AppSizes.h8),
                          CustomTextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            prefixIcon: Icons.email_outlined,
                            hintText: t.enterYourEmail,
                            validator: Validators.email,
                          ),

                          SizedBox(height: AppSizes.ph20),

                          Text(t.password, style: textTheme.labelLarge),
                          SizedBox(height: AppSizes.h8),
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
                                size: AppSizes.sp20,
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
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppSizes.sp13,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: AppSizes.h8),

                          SizedBox(
                            width: double.infinity,
                            height: AppSizes.h56,
                            child: ElevatedButton(
                              onPressed: controller.isLoading
                                  ? null
                                  : controller.login,
                              child: controller.isLoading
                                  ? LoadingAnimationWidget.fourRotatingDots(
                                      color: Colors.blue,
                                      size: AppSizes.sp25,
                                    )
                                  : Text(
                                      t.login,
                                      style: TextStyle(
                                        fontSize: AppSizes.sp16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                            ),
                          ),

                          SizedBox(height: AppSizes.h40),

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
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: AppSizes.sp14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: AppSizes.ph20),
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

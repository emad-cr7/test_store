import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:ql/core/l10n/app_localizations.dart';
import 'package:ql/features/auth/login/login_screen.dart';
import 'package:ql/features/auth/register/register_controller.dart';

import '../../../core/share/validators/validators.dart';
import '../../../core/share/widgets/custom_text_formField.dart';
import '../../../core/theming/app_sizes.dart';


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
                                Icons.person_add_alt_1_outlined,
                                size: AppSizes.sp42,
                                color: colors.onPrimary,
                              ),
                            ),
                          ),

                          SizedBox(height: AppSizes.h32),

                          Text(
                            t.createAccount,
                            style: textTheme.titleLarge?.copyWith(
                              fontSize: AppSizes.sp30,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),

                          SizedBox(height: AppSizes.h6),

                          Text(
                            t.registerSubtitle,
                            style: textTheme.bodySmall?.copyWith(fontSize: AppSizes.sp15),
                          ),

                          SizedBox(height: AppSizes.h36),

                          Text(t.fullName, style: textTheme.labelLarge),
                          SizedBox(height: AppSizes.h8),
                          CustomTextFormField(
                            controller: controller.nameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            prefixIcon: Icons.person_outline,
                            hintText: t.enterYourFullName,
                            validator: Validators.name,
                          ),

                          SizedBox(height: AppSizes.ph20),

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
                                size: AppSizes.sp20,
                              ),
                              onPressed: controller.togglePassword
                            ),
                          ),

                          SizedBox(height: AppSizes.ph20),

                          Text(t.confirmPassword, style: textTheme.labelLarge),
                          SizedBox(height: AppSizes.h8),
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
                                size: AppSizes.sp20,
                              ),
                              onPressed: controller.toggleConfirmPassword
                            ),
                          ),

                          SizedBox(height: AppSizes.h28),

                          SizedBox(
                            width: double.infinity,
                            height: AppSizes.h56,
                            child: ElevatedButton(
                              onPressed: controller.isLoading ? null : controller.register,
                              child: controller.isLoading
                                  ? LoadingAnimationWidget.fourRotatingDots(
                                      color: Colors.blue,
                                      size: AppSizes.sp25,
                                    )
                                  : Text(
                                      t.register,
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

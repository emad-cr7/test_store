import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:ql/features/profile/presentation/controllers/change_password_controller.dart';
import 'package:ql/features/profile/presentation/widgets/password_field.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/share/validators/validators.dart';
import '../../../auth/login/forget_password/forget_password_screen.dart';
import '../../../../core/theming/app_sizes.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;
    return ChangeNotifierProvider(
      create: (BuildContext context) => ChangePasswordController(),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<ChangePasswordController>(
            builder: ( context,  controller,
                Widget? child) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.w26, vertical: AppSizes.ph20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSizes.h10),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios_new, size: AppSizes.sp20),
                      ),
                      SizedBox(height: AppSizes.ph20),
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
                            Icons.lock_reset_outlined,
                            size: AppSizes.sp42,
                            color: colors.onPrimary,
                          ),
                        ),
                      ),
                       SizedBox(height: AppSizes.h32),
                      Text(
                        t.changePassword,
                        style: textTheme.titleLarge?.copyWith(
                          fontSize: AppSizes.sp30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                       SizedBox(height: AppSizes.h6),
                      Text(
                        t.changePasswordSubtitle,
                        style: textTheme.bodySmall?.copyWith(fontSize: AppSizes.sp15),
                      ),

                       SizedBox(height: AppSizes.h36),
                      PasswordField(
                        controller: controller.currentPasswordController,
                        obscureText: controller.obscureCurrentPassword,
                        label: t.currentPassword,
                        hintText: t.enterCurrentPassword,
                        prefixIcon: Icons.lock_outline,
                        onToggle: controller.toggleCurrentPassword,
                        validator: (value) => Validators.required(
                          value,
                          t.pleaseEnterCurrentPassword,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ForgetPasswordScreen(),
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
                      PasswordField(
                        controller: controller.newPasswordController,
                        obscureText: controller.obscureNewPassword,
                        label: t.newPassword,
                        hintText: t.enterNewPassword,
                        prefixIcon: Icons.lock_reset_outlined,
                        onToggle: controller.toggleNewPassword,
                        validator: Validators.password,
                      ),

                      SizedBox(height: AppSizes.h22),

                      PasswordField(
                        controller: controller.confirmPasswordController,
                        obscureText: controller.obscureConfirmPassword,
                        label: t.confirmNewPassword,
                        hintText: t.confirmNewPasswordHint,
                        prefixIcon: Icons.lock_outline,
                        onToggle: controller.toggleConfirmPassword,
                        textInputAction: TextInputAction.done,
                        validator: (value) => Validators.confirmPassword(
                          value,
                          controller.newPasswordController.text,
                        ),
                      ),
                      SizedBox(height: AppSizes.h36,),
                      SizedBox(
                        width: double.infinity,
                        height: AppSizes.h56,
                        child: ElevatedButton(
                          onPressed: controller.isLoading ? null : controller.changePassword,
                          child: controller.isLoading
                              ? LoadingAnimationWidget.fourRotatingDots(
                            color: colors.onPrimary,
                            size: AppSizes.sp25,
                          )
                              : Text(
                            t.changePassword,
                            style: TextStyle(
                              fontSize: AppSizes.sp16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: AppSizes.h40),
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
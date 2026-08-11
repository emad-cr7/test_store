import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:ql/features/profile/widget_profile/change_password_controller.dart';
import 'package:ql/features/profile/widget_profile/password_field.dart';
import '../../../core/share_widget/validators.dart';
import '../../auth/login/forget_password/forget_password_screen.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return ChangeNotifierProvider(
      create: (BuildContext context) => ChangePasswordController(),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<ChangePasswordController>(
            builder: ( context,  controller,
                Widget? child) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                child: Form(
                  key: controller.formKey,
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
                       SizedBox(height: 32),
                      Text(
                        'Change Password',
                        style: textTheme.titleLarge?.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                       SizedBox(height: 6),
                      Text(
                        'Enter your current password and choose a new password',
                        style: textTheme.bodySmall?.copyWith(fontSize: 15),
                      ),

                       SizedBox(height: 36),
                      PasswordField(
                        controller: controller.currentPasswordController,
                        obscureText: controller.obscureCurrentPassword,
                        label: 'Current Password',
                        hintText: 'Enter current password',
                        prefixIcon: Icons.lock_outline,
                        onToggle: controller.toggleCurrentPassword,
                        validator: (value) => Validators.required(
                          value,
                          'Please enter your current password',
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
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      PasswordField(
                        controller: controller.newPasswordController,
                        obscureText: controller.obscureNewPassword,
                        label: 'New Password',
                        hintText: 'Enter new password',
                        prefixIcon: Icons.lock_reset_outlined,
                        onToggle: controller.toggleNewPassword,
                        validator: Validators.password,
                      ),

                      const SizedBox(height: 22),

                      PasswordField(
                        controller: controller.confirmPasswordController,
                        obscureText: controller.obscureConfirmPassword,
                        label: 'Confirm New Password',
                        hintText: 'Confirm new password',
                        prefixIcon: Icons.lock_outline,
                        onToggle: controller.toggleConfirmPassword,
                        textInputAction: TextInputAction.done,
                        validator: (value) => Validators.confirmPassword(
                          value,
                          controller.newPasswordController.text,
                        ),
                      ),
                      SizedBox(height: 36,),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: controller.isLoading ? null : controller.changePassword,
                          child: controller.isLoading
                              ? LoadingAnimationWidget.fourRotatingDots(
                            color: colors.onPrimary,
                            size: 25,
                          )
                              : const Text(
                            'Change Password',
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
              );
            },
          ),
        ),
      ),
    );
  }
}
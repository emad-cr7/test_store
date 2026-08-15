import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/share/validators/validators.dart';
import '../../../../core/share/widgets/custom_text_formField.dart';
import 'forget_password_controller.dart';
import '../../../../core/theming/app_sizes.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => ForgetPasswordController(),
        child: SafeArea(
          child: Consumer<ForgetPasswordController>(
            builder: (context, controller, Widget? child) {
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
                                color: colors.primary.withOpacity(0.25),
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
                        t.forgotPassword,
                        style: textTheme.titleLarge?.copyWith(
                          fontSize: AppSizes.sp30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),

                      SizedBox(height: AppSizes.h6),

                      Text(
                        t.forgotPasswordSubtitle,
                        style: textTheme.bodySmall?.copyWith(fontSize: AppSizes.sp15),
                      ),

                      SizedBox(height: AppSizes.h36),

                      Text(t.email, style: textTheme.labelLarge),
                      SizedBox(height: AppSizes.h8),
                      CustomTextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icons.email_outlined,
                        hintText: t.enterYourEmail,
                        validator: Validators.email,
                      ),

                      SizedBox(height: AppSizes.h36),

                      SizedBox(
                        width: double.infinity,
                        height: AppSizes.h56,
                        child: ElevatedButton(
                          onPressed: controller.isLoading
                              ? null
                              : controller.forgetPassword,
                          child: controller.isLoading
                              ? LoadingAnimationWidget.fourRotatingDots(
                                  color: Colors.blue,
                                  size: AppSizes.sp25,
                                )
                              : Text(
                                  t.sendResetLink,
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

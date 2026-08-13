import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/share/validators/validators.dart';
import '../../../../core/share/widgets/custom_text_formField.dart';
import 'forget_password_controller.dart';

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 20,
                ),
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

                      const SizedBox(height: 32),

                      Text(
                        t.forgotPassword,
                        style: textTheme.titleLarge?.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        t.forgotPasswordSubtitle,
                        style: textTheme.bodySmall?.copyWith(fontSize: 15),
                      ),

                      const SizedBox(height: 36),

                      Text(t.email, style: textTheme.labelLarge),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icons.email_outlined,
                        hintText: t.enterYourEmail,
                        validator: Validators.email,
                      ),

                      const SizedBox(height: 36),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: controller.isLoading
                              ? null
                              : controller.forgetPassword,
                          child: controller.isLoading
                              ? LoadingAnimationWidget.fourRotatingDots(
                                  color: Colors.blue,
                                  size: 25,
                                )
                              : Text(
                                  t.sendResetLink,
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

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../../core/l10n/app_localizations.dart';

import '../../../../core/share/validators/validators.dart';
import '../../../../core/share/widgets/custom_text_formField.dart';
import '../controllers/edit_name_controller.dart';
import '../../../../core/theming/app_sizes.dart';

Future<void> showEditNameBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const EditNameBottomSheet(),
  );
}

class EditNameBottomSheet extends StatelessWidget {
  const EditNameBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;

    return ChangeNotifierProvider(
      create: (_) => EditNameController(),
      child: Consumer<EditNameController>(
        builder: (context, controller, child) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSizes.r24),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: AppSizes.pw24, vertical: AppSizes.ph24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: AppSizes.w44,
                        height: AppSizes.h5,
                        decoration: BoxDecoration(
                          color: colors.outlineVariant,
                          borderRadius: BorderRadius.circular(AppSizes.r10),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.ph20),
                    Text(
                      t.editProfile,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: AppSizes.h6),
                    Text(t.editProfileSubtitle, style: textTheme.bodySmall),
                    SizedBox(height: AppSizes.h24),
                    CustomTextFormField(
                      controller: controller.nameController,
                      prefixIcon: Icons.person_outline,
                      hintText: t.enterYourFullName,
                      textInputAction: TextInputAction.done,
                      validator: Validators.name,
                    ),
                    SizedBox(height: AppSizes.h28),
                    Row(
                      children: [
                        SizedBox(width: AppSizes.w16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controller.isLoading
                                ? null
                                : controller.updateName,
                            child: controller.isLoading
                                ? LoadingAnimationWidget.fourRotatingDots(
                                    color: colors.onPrimary,
                                    size: AppSizes.sp22,
                                  )
                                : Text(t.save),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.h12),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

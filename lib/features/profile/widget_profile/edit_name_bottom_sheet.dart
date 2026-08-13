import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';

import '../../../core/share/validators/validators.dart';
import '../../../core/share/widgets/custom_text_formField.dart';
import 'edit_name_controller.dart';

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
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 44,
                        height: 5,
                        decoration: BoxDecoration(
                          color: colors.outlineVariant,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      t.editProfile,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(t.editProfileSubtitle, style: textTheme.bodySmall),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      controller: controller.nameController,
                      prefixIcon: Icons.person_outline,
                      hintText: t.enterYourFullName,
                      textInputAction: TextInputAction.done,
                      validator: Validators.name,
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controller.isLoading
                                ? null
                                : controller.updateName,
                            child: controller.isLoading
                                ? LoadingAnimationWidget.fourRotatingDots(
                                    color: colors.onPrimary,
                                    size: 22,
                                  )
                                : Text(t.save),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
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

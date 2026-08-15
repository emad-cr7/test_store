import 'package:flutter/material.dart';

import '../../../../core/share/widgets/custom_text_formField.dart';
import '../../../../core/theming/app_sizes.dart';


class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final VoidCallback onToggle;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  const PasswordField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    required this.onToggle,
    this.validator,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelLarge,
        ),
        SizedBox(height: AppSizes.h8),
        CustomTextFormField(
          controller: controller,
          obscureText: obscureText,
          textInputAction: textInputAction,
          prefixIcon: prefixIcon,
          hintText: hintText,
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
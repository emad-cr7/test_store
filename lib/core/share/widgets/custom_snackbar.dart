import 'package:flutter/material.dart';
import '../../theming/app_sizes.dart';

class AppSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        required IconData icon,
        required Color backgroundColor,
        Color iconColor = Colors.white,
        Color textColor = Colors.white,
        Duration duration = const Duration(seconds: 2),
      }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: AppSizes.h85,
            left: AppSizes.w20,
            right: AppSizes.w20,
          ),

          backgroundColor: backgroundColor,
          duration: duration,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),

          content: Row(
            children: [
              Icon(icon, color: iconColor),
              SizedBox(width: AppSizes.w10),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          ),
        )
    );
  }
}
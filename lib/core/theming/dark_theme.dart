import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
  primaryColor: AppColors.darkPrimary,
  cardColor: AppColors.darkSurface,
  dividerColor: AppColors.darkFieldFill,

  colorScheme: const ColorScheme.dark(
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkAccent,
    surface: AppColors.darkSurface,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: AppColors.darkTextPrimary,
    error: Colors.redAccent,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.darkTextPrimary,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
    titleTextStyle: TextStyle(
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.bold,
      color: AppColors.darkTextPrimary,
    ),
  ),

  iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),


   textTheme: TextTheme(
     titleLarge: TextStyle(
       color: AppColors.darkTextPrimary,
       fontWeight: FontWeight.bold,
       fontSize: AppSizes.sp22,
     ),
     bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
     bodyMedium: TextStyle(color: AppColors.darkTextPrimary),
     bodySmall: TextStyle(color: AppColors.darkTextSecondary),
     labelLarge: TextStyle(color: AppColors.darkTextPrimary, fontWeight: FontWeight.w600,),
   ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      minimumSize: const Size.fromHeight(56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColors.darkAccent),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkFieldFill,
    hintStyle: TextStyle(
      color: AppColors.darkTextSecondary,
      fontSize: AppSizes.sp14,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: AppSizes.h18, horizontal: AppSizes.pw16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: AppColors.darkPrimary, width: AppSizes.w1_5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Colors.redAccent, width: AppSizes.w1_2),
    ),
  ),

  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
          ? AppColors.darkAccent
          : Colors.grey.shade600,
    ),
    trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
          ? AppColors.darkAccent.withValues(alpha: 0.5)
          : Colors.grey.shade800,
    ),
  ),
);

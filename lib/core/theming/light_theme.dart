import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackground,
  primaryColor: AppColors.lightPrimary,
  cardColor: AppColors.lightSurface,
  dividerColor: AppColors.lightFieldFill,

  colorScheme: const ColorScheme.light(
    primary: AppColors.lightPrimary,
    secondary: AppColors.lightAccent,
    surface: AppColors.lightSurface,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.lightTextPrimary,
    error: Colors.redAccent,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightPrimary,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

  iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: AppColors.lightTextPrimary,
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.sp22,
    ),
    bodyLarge: TextStyle(color: AppColors.lightTextPrimary),
    bodyMedium: TextStyle(color: AppColors.lightTextPrimary),
    bodySmall: TextStyle(color: AppColors.lightTextSecondary),
    labelLarge: TextStyle(
      color: AppColors.lightTextPrimary,
      fontWeight: FontWeight.w600,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      minimumSize: const Size.fromHeight(56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.r16)),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColors.lightPrimary),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.lightFieldFill,
    hintStyle: TextStyle(
      color: AppColors.lightTextSecondary,
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
      borderSide: BorderSide(color: AppColors.lightPrimary, width: AppSizes.w1_5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Colors.redAccent, width: AppSizes.w1_2),
    ),
  ),

  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
          ? AppColors.lightAccent
          : Colors.grey.shade400,
    ),
    trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
          ? AppColors.lightAccent.withValues(alpha: 0.5)
          : Colors.grey.shade300,
    ),
  ),
);

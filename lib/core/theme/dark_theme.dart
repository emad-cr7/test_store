import 'package:flutter/material.dart';
import 'app_colors.dart';

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

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.darkTextPrimary,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.darkTextPrimary,
    ),
  ),

  iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: AppColors.darkTextPrimary,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: AppColors.darkTextPrimary,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: 32,
      color: AppColors.darkTextPrimary,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: AppColors.darkTextPrimary,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: AppColors.darkTextPrimary,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: AppColors.darkTextPrimary,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decorationColor: AppColors.darkTextPrimary,
    ),
    labelSmall: TextStyle(color: Color(0XFFFFFCFC), fontSize: 16),
    labelMedium: TextStyle(color: Color(0XFFFFFCFC), fontSize: 24),
  ),


  // textTheme: const TextTheme(
  //   titleLarge: TextStyle(
  //     color: AppColors.darkTextPrimary,
  //     fontWeight: FontWeight.bold,
  //     fontSize: 22,
  //   ),
  //   bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
  //   bodyMedium: TextStyle(color: AppColors.darkTextPrimary),
  //   bodySmall: TextStyle(color: AppColors.darkTextSecondary),
  //   labelLarge: TextStyle(color: AppColors.darkTextPrimary, fontWeight: FontWeight.w600,),
  // ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      minimumSize: const Size.fromHeight(56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColors.darkAccent),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkFieldFill,
    hintStyle: const TextStyle(
      color: AppColors.darkTextSecondary,
      fontSize: 14,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.darkPrimary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
    ),
  ),

  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith(
      (states) => states.contains(MaterialState.selected)
          ? AppColors.darkAccent
          : Colors.grey.shade600,
    ),
    trackColor: MaterialStateProperty.resolveWith(
      (states) => states.contains(MaterialState.selected)
          ? AppColors.darkAccent.withOpacity(0.5)
          : Colors.grey.shade800,
    ),
  ),
);

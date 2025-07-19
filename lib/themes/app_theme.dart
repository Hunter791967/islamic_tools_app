import 'package:flutter/material.dart';

import '../utils/appColors/app_colors.dart';

class AppTheme {
  //LightTheme
  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.dPrimary,
      onPrimary: AppColors.dOnPrimary,
      secondary: AppColors.dSecondary,
      onSecondary: Color(0xfffaf9f6),
      error: AppColors.dWhite,
      onError: AppColors.dWhite,
      surface: AppColors.dService,
      onSurface: Color(0xfffaf9f6),
    ),
    dividerColor: Colors.white.withOpacity(0.3), // ✅ cleaner and visible,
    // Add other custom light theme properties
  );

  //DarkTheme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    //scaffoldBackgroundColor: Colors.black,
    // appBarTheme: const AppBarTheme(
    //   backgroundColor: Colors.grey,
    //   foregroundColor: Colors.white,
    // ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkOverlay,
      onPrimary: AppColors.dOnPrimary,
      secondary: AppColors.darkPrimary,
      onSecondary: AppColors.dWhite,
      surface: AppColors.dService,
      onSurface: Colors.white,
      error: AppColors.darkPrimary,
      onError: AppColors.dWhite,
    ),
    // Add other custom dark theme properties
    dividerColor: Colors.white.withOpacity(0.2), // ✅ cleaner and visible,
  );
}

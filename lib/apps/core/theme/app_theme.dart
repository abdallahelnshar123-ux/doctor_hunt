import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Rubik',
    fontFamilyFallback: const ['Cairo'],
    popupMenuTheme: const PopupMenuThemeData(color: AppColors.white),
    dialogTheme: const DialogThemeData(backgroundColor: AppColors.white),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: AppColors.brandPrimary,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.transparent,
      type: BottomNavigationBarType.shifting,
    ),
    scaffoldBackgroundColor: AppColors.bgPrimary,
    appBarTheme: const AppBarTheme(
      leadingWidth: 70,
      backgroundColor: AppColors.transparent,
      elevation: 0,
      surfaceTintColor: AppColors.transparent,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontFamily: 'Rubik',
        fontFamilyFallback: ['Cairo'],
      ),
    ),
  );
}

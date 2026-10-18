import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    popupMenuTheme: PopupMenuThemeData(color: AppColors.white),
    dialogTheme: DialogThemeData(backgroundColor: AppColors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.transparent,
      type: BottomNavigationBarType.shifting,
    ),
    scaffoldBackgroundColor: AppColors.bgPrimary,
    appBarTheme: AppBarTheme(
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
      ),
    ),
  );
}

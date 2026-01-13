import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.darkBlue,
      primaryColor: AppColors.mediumBlue,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.white),
        titleTextStyle: AppTextStyles.heading,
      ),
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.heading,
        titleMedium: AppTextStyles.subtitle,
        bodyMedium: AppTextStyles.description,
        labelLarge: AppTextStyles.button,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.lightBlue,
        brightness: Brightness.dark,
      ),
    );
  }
}

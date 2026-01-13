import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle logo = TextStyle(
    fontFamily: 'MadimiOne',
    fontSize: 40,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static const TextStyle onboarding = TextStyle(
    fontFamily: 'Geist',
    fontSize: 18,
    color: AppColors.white,
  );

  static const TextStyle description = TextStyle(
    fontFamily: 'GESS',
    fontSize: 16,
    color: AppColors.white,
    height: 1.5,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static const TextStyle bottomBar = TextStyle(
    fontFamily: 'Afacad',
    fontSize: 14,
    color: AppColors.white,
  );
}

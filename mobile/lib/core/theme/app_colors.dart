import 'package:flutter/material.dart';

class AppColors {
  static const Color darkBlue = Color(0xFF010920);
  static const Color navyBlue = Color(0xFF002F67);
  static const Color mediumBlue = Color(0xFF0196D0);
  static const Color lightBlue = Color(0xFF4DD7FF);
  static const Color white = Color(0xFFFFFFFF);

  // التدرج اللوني المستخدم في الخلفية العامة
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.01, 0.30, 0.60, 0.91],
    colors: [
      lightBlue,
      mediumBlue,
      navyBlue,
      darkBlue,
    ],
  );
}

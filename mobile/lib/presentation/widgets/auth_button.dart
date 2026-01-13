import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';



/// زر تسجيل بواسطة حسابات التواصل الاجتماعي
Widget socialButton(String assetPath) {
  return GestureDetector(
    onTap: () {
      // : منطق تسجيل الدخول بالحساب الاجتماعي
    },
    child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(assetPath),
      ),
    ),
  );
}


// زر التسجيل أو تسجيل الدخول
Widget buildButton(String text, {VoidCallback? onPressed}) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: InkWell(
      onTap: onPressed, 
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            stops: [0.25, 0.70, 0.99],
            colors: [Color(0xFF4DD7FF), Color(0xFF00669F), Color(0xFF001B42)],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.button.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
    ),
  );
}


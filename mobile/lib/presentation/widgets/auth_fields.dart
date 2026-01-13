import 'package:flutter/material.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';

// حقل إدخال
Widget buildField({
  required String label,
  required IconData icon,
  required String hint,
  bool obscure = false,
  String? Function(String?)? validator,
  TextEditingController? controller,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    validator: validator,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      labelText: label,
      hintText: hint,
      hintStyle: AppTextStyles.button.copyWith(color: Colors.white30, fontSize: 14),
      labelStyle: AppTextStyles.button.copyWith(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      errorStyle: TextStyle(
      color: Colors.red[300],
      fontSize: 13,
      fontWeight: FontWeight.w600
  ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 1.5),
      ),
    ),
    style: AppTextStyles.button.copyWith(color: Colors.white),
  );
}

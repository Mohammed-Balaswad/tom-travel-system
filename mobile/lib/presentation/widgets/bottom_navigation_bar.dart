// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

import 'package:tom_travel_app/core/theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Stack(
          children: [
            // تأثير الضباب داخل البار فقط
            Container(
              // color: AppColors.white.withOpacity(0.7),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 500, sigmaY: 500),
              child: Container(color: Colors.transparent),
            ),

            // طبقة اللون نصف الشفافة فوق الضباب
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              decoration: BoxDecoration(
                color: AppColors.mediumBlue.withOpacity(0.3), // لون الشريط
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 7.9,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNavItem(
                    'assets/icons/white_explore_icon.svg',
                    'Explore',
                    0,
                  ),
                  const SizedBox(width: 40),
                  _buildNavItem(
                    'assets/icons/white_calender_icon.svg',
                    'My trip',
                    1,
                  ),
                  const SizedBox(width: 40),
                  _buildNavItem(
                    'assets/icons/white_hart_icon.svg',
                    'Favorite',
                    2,
                  ),
                  const SizedBox(width: 40),
                  _buildNavItem(
                    'assets/icons/profile.svg',
                    'Profile',
                    3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String path, String label, int index) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: SizedBox(
        width: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              path,
              colorFilter: ColorFilter.mode(
                isSelected ? const Color.fromARGB(255, 2, 47, 252) : Colors.white,
                BlendMode.srcIn,
              ),
              width: isSelected ? 24 : 22,
              height: isSelected ? 24 : 22,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: isSelected ? 14 : 10,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                color: isSelected ? const Color.fromARGB(255, 2, 47, 252) : Colors.white,
                letterSpacing: isSelected ? -0.32 : -0.24,
                height: 1.04,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

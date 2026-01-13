import 'package:flutter/material.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';


class AppBackground extends StatelessWidget {
  final Widget child;
  final BoxDecoration? decorationOverride;

  const AppBackground({super.key, required this.child, this.decorationOverride});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationOverride ??
          const BoxDecoration(
            gradient: AppColors.mainGradient,
          ),
      child: child,
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';
import 'package:tom_travel_app/presentation/widgets/app_background.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double logoScale = 0.8;
  double logoOpacity = 0.0;
  bool switchToLight = false;

  @override
  void initState() {
    super.initState();
    // سلسلة أنيميشن بسيطة:
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        logoOpacity = 1.0;
        logoScale = 1.05;
      });
    });

    // بعد بعض الوقت نعمل fade/transition للخلفية ثم ننتقل للـ Onboarding
    Future.delayed(const Duration(milliseconds: 1800), () {
      setState(() {
        logoScale = 0.98;
        switchToLight = true; // نستخدمه لتغيير overlay
      });
    });

    Future.delayed(const Duration(milliseconds: 2400), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const OnboardingScreen(),
          transitionsBuilder: (_, anim, __, child) {
            return FadeTransition(opacity: anim, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // نضع overlay لتفتيح الخلفية عندما switchToLight = true
    return Scaffold(
      body: AppBackground(
        child: Stack(
          children: [
            // مركزية الشعار
            Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 450),
                opacity: logoOpacity,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 450),
                  scale: logoScale,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // الشعار (SVG)
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: SvgPicture.asset(
                          'assets/icons/logo_icon.svg',
                          color: switchToLight ? AppColors.darkBlue : AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your journey\nstarts with TOM',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.onboarding.copyWith(
                          color: switchToLight ? AppColors.darkBlue : AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Overlay لتغيير اللون بالتدرج الفاتح (fade)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              top: switchToLight ? -MediaQuery.of(context).size.height * 0.05 : MediaQuery.of(context).size.height,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4DD7FF), // light
                      Color(0xFF0196D0),
                    ],
                  ),
                ),
                // شفافية مع إمكانية رؤية التدرج الرئيسي تحت
                // قد نخفيها أو نجعلها متدرجة، هنا فقط لإحساس الانتقال
                child: const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

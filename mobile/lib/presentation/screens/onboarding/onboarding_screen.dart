// ignore_for_file: deprecated_member_use, must_be_immutable, unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';
import 'package:tom_travel_app/presentation/widgets/app_background.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  bool showGetStarted = false;

  final List<_OnboardPageData> pages = [
    _OnboardPageData(
      image: 'assets/images/onboarding/Man-with-baggage.png',
      titleParts: ['Let\'s Enjoy the', 'Beautiful World!'],
      subtitle:
          'Plan, book, and enjoy every trip with ease. Hotels, flights, and attractions all in one place designed to make your travel stress-free.',
    ),
    _OnboardPageData(
      image: 'assets/images/onboarding/Man.png',
      titleParts: ['Explore Beyond', 'Limits!'],
      subtitle:
          'From breathtaking destinations to hidden gems, your journey starts with just one swipe.',
    ),
    _OnboardPageData(
      image: 'assets/images/onboarding/Women.png',
      titleParts: ['Your Journey,', 'Your Way'],
      subtitle:
          'Save favorites, track bookings, and explore the world the way you dream it.',
    ),
  ];

  void _next() {
    if (currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // navigate to login
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              // PageView (الجزء الرئيسي)
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (i) => setState(() => currentIndex = i),
                  itemBuilder: (context, index) {
                    final p = pages[index];
                    return _OnboardPage(
                      viewData: p,
                      currentIndex: index,
                      totalPages: pages.length,
                    );
                  },
                ),
              ),

              // Indicators + Next button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.r, vertical: 12.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 12.r, right: 12.r),
                        child: TextButton(
                          onPressed: () {
                            if (currentIndex == 0) {
                              Navigator.pushReplacementNamed(context, '/login');
                            } else {
                              _controller.previousPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.ease,
                              );
                            }
                          },
                          child: Text(
                            currentIndex == 0 ? 'Skip' : 'Back',
                            style: AppTextStyles.button.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: AppColors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Next button
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child:
                          currentIndex == pages.length - 1
                              ? showGetStarted
                                  ? ElevatedButton(
                                    key: const ValueKey('getStarted'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.white,
                                      shape: const StadiumBorder(),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 42.r,
                                        vertical: 10.r,
                                      ),
                                      elevation: 6,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/login',
                                      );
                                    },
                                    child: Text(
                                      'Get Started',
                                      style: AppTextStyles.button.copyWith(
                                        color: AppColors.darkBlue,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                  : ElevatedButton(
                                    key: const ValueKey('nextIcon'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.white,
                                      shape: const CircleBorder(),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 18.r,
                                        vertical: 14.r,
                                      ),
                                      elevation: 6,
                                    ),
                                    onPressed: () {
                                      setState(() => showGetStarted = true);
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/next_icon.svg',
                                    ),
                                  )
                              : ElevatedButton(
                                key: const ValueKey('nextNormal'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.white,
                                  shape: const CircleBorder(),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 18.r,
                                    vertical: 14.r,
                                  ),
                                  elevation: 6,
                                ),
                                onPressed: _next,
                                child: SvgPicture.asset(
                                  'assets/icons/next_icon.svg',
                                ),
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardPageData {
  final String image;
  final List<String>
  titleParts; // titleParts[0] before highlight, [1] highlighted
  final String subtitle;
  _OnboardPageData({
    required this.image,
    required this.titleParts,
    required this.subtitle,
  });
}

class _OnboardPage extends StatelessWidget {
  final _OnboardPageData viewData;
  final int currentIndex;
  final int totalPages;

  const _OnboardPage({
    super.key,
    required this.viewData,
    required this.currentIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasHighlight = viewData.titleParts.length > 1;

    return Column(
      children: [
        // hero image 
        Padding(
          padding: EdgeInsets.zero,
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.55,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
              child: Image.asset(viewData.image, fit: BoxFit.contain),
            ),
          ),
        ),

        // Indicators
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            totalPages,
            (i) {
              final isActive = i == currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 6.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isActive)
                      Container(
                        width: 26.r,
                        height: 26.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.lightBlue,
                            width: 2.r,
                          ),
                        ),
                      ),

                    // الدائرة الداخلية
                    Container(
                      width: isActive ? 10.r : 8.r,
                      height: isActive ? 10.r : 8.r,
                      decoration: BoxDecoration(
                        color:
                            isActive
                                ? AppColors.lightBlue
                                : AppColors.lightBlue.withOpacity(0.25),
                        shape: BoxShape.circle,
                        boxShadow:
                            isActive
                                ? [
                                  BoxShadow(
                                    color: AppColors.lightBlue.withOpacity(0.1),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ]
                                : [],
                      ),
                    ),
                  ],
                ),
              );
            },
          ).animate().fade(duration: 600.ms, delay: 100.ms).slideX(begin: -0.2),
        ),

        SizedBox(height: 22.h),
        // Title + Subtitle
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 34.r, vertical: 16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichTitle(
                  before: viewData.titleParts[0],
                  highlight: hasHighlight ? viewData.titleParts[1] : '',
                ),
                SizedBox(height: 18.h),
                Text(
                  viewData.subtitle,
                  style: AppTextStyles.description.copyWith(
                    color: AppColors.white.withOpacity(0.8),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Title widget that draws a small rounded rectangle highlight behind the second part
class RichTitle extends StatelessWidget {
  final String before;
  final String highlight;

  const RichTitle({super.key, required this.before, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        // before
        Text(
          before,
          style: AppTextStyles.onboarding.copyWith(
            fontSize: 22.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),

        // highlight row: rectangle behind text
        if (highlight.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(6.r), 
            ),
            child: Text(
              highlight,
              style: AppTextStyles.onboarding.copyWith(
                fontSize: 22.sp,
                color: AppColors.navyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

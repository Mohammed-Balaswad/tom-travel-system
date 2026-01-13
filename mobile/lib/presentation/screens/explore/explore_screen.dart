// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tom_travel_app/data/models/search_result_model.dart';
import 'package:tom_travel_app/logic/cubits/destination_cubit.dart';
import 'package:tom_travel_app/logic/cubits/hotel_cubit.dart';
import 'package:tom_travel_app/logic/cubits/search_cubit.dart';
import 'package:tom_travel_app/logic/states/destination_states.dart';
import 'package:tom_travel_app/logic/states/hotel_states.dart';
import 'package:tom_travel_app/presentation/widgets/favorite_icon.dart';
import '../../widgets/app_background.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int selectedIndex = 0;

  @override
void initState() {
  super.initState();
  context.read<DestinationCubit>().fetchDestinations();
  context.read<HotelCubit>().fetchHotels();
}


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
  
    return Scaffold(
      resizeToAvoidBottomInset: false, // لمنع طلوع البار فوق الكيبورد
      body: AppBackground(
        child: Stack(
          children: [
            //  الدائرة البيضاء في الأعلى (ثابتة)
            Positioned(
              top: -size.width * 0.4,
              left: -size.width * 0.1,
              child: Container(
                width: size.width * 1.2,
                height: size.width * 1.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width * 0.6),
                    topRight: Radius.circular(size.width * 0.6),
                    bottomLeft: Radius.circular(size.width * 0.5),
                    bottomRight: Radius.circular(size.width * 0.5),
                  ),
                ),
              ),
            ),

            //  المحتوى الكامل داخل SafeArea و Column
            SafeArea(
              child: Column(
                children: [
                  _buildHeaderSection(context)
                      .animate()
                      .fade(duration: 600.ms, delay: 300.ms)
                      .slideY(begin: 0.2),

                   SizedBox(height: 30.h),

                  _buildSearchSection(context)
                      .animate()
                      .fade(duration: 600.ms, delay: 500.ms)
                      .slideY(begin: 0.2),
                      
                   SizedBox(height: 50.h),
                  

                  //  المحتوى المتحرك داخل ShaderMask لتأثير التلاشي
                  Expanded(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent, 
                            Colors.white, 
                          ],
                          stops: [
                            0.0,
                            0.11,
                          ],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.width * 0.11),
                            
                            _buildCategoriesSection(context).animate()
                          .fade(duration: 600.ms, delay: 700.ms)
                          .slideY(begin: 0.2),

                             SizedBox(height: 40.h),

                            _buildPopularDestinationsSection(context).animate()
                          .fade(duration: 600.ms, delay: 900.ms)
                          .slideY(begin: 0.2),

                             SizedBox(height: 30.h),

                            _buildTopHotelsSection(context).animate()
                          .fade(duration: 600.ms, delay: 1100.ms)
                          .slideY(begin: 0.2),

                             SizedBox(height: 50.h),
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
      

      
    );
  }

  // ---------------- Header Section ----------------
  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Find your",
                style: AppTextStyles.heading.copyWith(
                  color: AppColors.navyBlue,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "favorite place",
                style: AppTextStyles.heading.copyWith(
                  color: AppColors.navyBlue,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            height: 50.h,
            width: 50.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[50],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                'assets/icons/notifications_icon.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Search Section ----------------
Widget _buildSearchSection(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Row(
      children: [
        // ---- نص البحث + قائمة الاقتراحات أسفلها ----
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TextField (نفس الشكل بالضبط)
              TextField(
                style: const TextStyle(color: AppColors.navyBlue),
                onChanged: (value) {
                  // ننادي الـ cubit لكل تغيير (ابتداءً من حرفين في الكيوبت نفسه)
                  context.read<SearchCubit>().search(value);
                },
                decoration: InputDecoration(
                  hintText: "Search Destination, Hotels ...",
                  hintStyle: AppTextStyles.button.copyWith(
                    color: AppColors.mediumBlue.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset('assets/icons/search_icon.svg'),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // المساحة الفاصلة الصغيرة
               SizedBox(height: 8.h),

              // BlocBuilder: يعرض الاقتراحات إن وُجِدت
              BlocBuilder<SearchCubit, List<SearchResultModel>>(
                builder: (context, results) {
                  if (results.isEmpty) return const SizedBox.shrink();

                  // صندوق الاقتراحات
                  return Container(
                    constraints:  BoxConstraints(
                      maxHeight: 320.h, // يحد الارتفاع حتى لا يملأ الشاشة
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: results.length,
                      separatorBuilder: (_, __) =>  Divider(height: 1.h),
                      itemBuilder: (context, i) {
                        final r = results[i];
                        return ListTile(
                          dense: true,
                          leading: CircleAvatar(
                            backgroundImage: r.image != null
                                ? NetworkImage(r.image!)
                                : const AssetImage(
                                    'assets/images/hotels/Hotel-de-Paris.jpg',
                                  ) as ImageProvider,
                          ),
                          title: Text(
                            r.title,
                            style: const TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(
                            r.subtitle ?? '',
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: r.type == 'hotel'
                                  ? AppColors.lightBlue.withOpacity(0.2)
                                  : AppColors.mediumBlue.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              r.type.toUpperCase(),
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                          onTap: () {
                            // عند النقر ننتقل لصفحة التفاصيل المناسبة
                            if (r.type == 'destination') {
                              Navigator.pushNamed(
                                context,
                                '/destination-details',
                                arguments: r.id,
                              );
                            } else {
                              Navigator.pushNamed(
                                context,
                                '/hotel-details',
                                arguments: r.id,
                              );
                            }

                            // نفرغ النتائج بعد الاختيار
                            context.read<SearchCubit>().clear();
                            // (اختياري) نغلق لوحة المفاتيح
                            FocusScope.of(context).unfocus();
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),

         SizedBox(width: 16.r),

        // ---- زر الفلتر كما هو ----
        Container(
          height: 52.h,
          width: 52.r,
          decoration: BoxDecoration(
            color: AppColors.mediumBlue,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset('assets/icons/filter_icon.svg'),
          ),
        ),
      ],
    ),
  );
}


  // ---------------- Categories Section ----------------
  Widget _buildCategoriesSection(BuildContext context) {
    final categories = [
      {'icon': 'assets/icons/sleeping.svg', 'label': 'Hotels'},
      {'icon': 'assets/icons/plane3.svg', 'label': 'Flights'},
      {'icon': 'assets/icons/food.svg', 'label': 'Restaurants'},
      {'icon': 'assets/icons/camera.svg', 'label': 'Attractions'},
    ];

    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) =>  SizedBox(width: 28.r),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return GestureDetector(
            onTap: () {
              //! منطق الفئات؟
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 64.h,
                    width: 66.r,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          cat['icon']!,
                          width: 38.r,
                          height: 38.h,
                          color: AppColors.mediumBlue,
                          // colorFilter:
                          //     const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: 8.h),
                Text(
                  cat['label']!,
                  style: AppTextStyles.heading.copyWith(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------------- Popular Destinations ----------------
Widget _buildPopularDestinationsSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader("Popular Destinations"),
       SizedBox(height: 8.h),

      BlocBuilder<DestinationCubit, DestinationState>(
        builder: (context, state) {
          if (state is DestinationLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          }

          if (state is DestinationError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          if (state is DestinationLoaded) {
  final destinations = state.destinations;

  return SizedBox(
    height: 240.h,
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => SizedBox(width: 16.r),
      itemCount: destinations.length > 3 ? 3 : destinations.length,
      itemBuilder: (context, index) {
        final item = destinations[index];

        
        return GestureDetector(
          onTap: () {
            // TODO الانتقال لتفاصيل الوجهة لاحقًا
          },
          child: Container(
            width: 160.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: item.image != null
                    ? NetworkImage(item.image!)
                    : const AssetImage('assets/images/destinations/Paris.png') as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.darkBlue.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),

                // Rating + Favorite Icon (مربوطة بحالة Cubit)
                Positioned(
                  top: 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Rating container (كما هو)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 1.r,
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/star_icon.svg'),
                            SizedBox(width: 4.r),
                            Text(
                              item.averageRating.toString(),
                              style: AppTextStyles.heading.copyWith(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      FavoriteIcon(type: "destination", itemId: item.id),
                    ],
                  ),
                ),

                // Country + City (كما هو)
                Positioned(
                  left: 10,
                  bottom: 12,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/location_icon.svg'),
                          SizedBox(width: 4.r),
                          Text(
                            item.country,
                            style: AppTextStyles.heading.copyWith(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        item.name,
                        style: AppTextStyles.heading.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1.2.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

          return const SizedBox();
        },
      ),
    ],
  );
}


  // ---------------- Top Hotels ----------------
  Widget _buildTopHotelsSection(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader("Top Hotels"),
       SizedBox(height: 8.h),

      BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          if (state is HotelLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          }

          if (state is HotelError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          if (state is HotelLoaded) {
            final hotels = state.hotels;

            return SizedBox(
              height: 240.h,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) =>  SizedBox(width: 16.r),
                itemCount: hotels.length > 3 ? 3 : hotels.length,
                itemBuilder: (context, index) {
                  final item = hotels[index];

                  return GestureDetector(
                    onTap: () {
                      // الانتقال لتفاصيل الفندق لاحقًا
                    },
                    child: Container(
                      width: 160.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: item.image != null
                              ? NetworkImage(item.image!)
                              : const AssetImage(
                                  'assets/images/hotels/Blue-horazin-hotel.jpg',
                                ) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Gradient overlay
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    AppColors.darkBlue.withOpacity(0.3),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Rating
                           Positioned(
                        top: 10,
                        left: 10,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.45),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 1.r,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/star_icon.svg',
                                  ),
                                   SizedBox(width: 4.r),
                                  Text(
                                        item.averageRating.toString(),
                                        style: AppTextStyles.heading.copyWith(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                               FavoriteIcon(type: "hotel", itemId: item.id),

                          ],
                        ),
                      ),

                          // Country + City
                          Positioned(
                            left: 10,
                            bottom: 12,
                            right: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/location_icon.svg',
                                    ),
                                     SizedBox(width: 4.r),
                                    Text(
                                      '${item.destination.country}, ${item.destination.name}',
                                      style:
                                          AppTextStyles.heading.copyWith(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  item.name,
                                  style: AppTextStyles.heading.copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    ],
  );
  }

  // ---------------- Helper: Section Title ----------------
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.heading.copyWith(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w300,
            ),
          ),
          TextButton(
            onPressed: () {
              //! منطق عرض الكل
            },
            child: Text(
              "View All",
              style: AppTextStyles.heading.copyWith(
                color: AppColors.lightBlue,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';
import 'package:tom_travel_app/data/models/favorite_model.dart';
import 'package:tom_travel_app/logic/cubits/favorites_cubit.dart';
import 'package:tom_travel_app/logic/states/favorites-states.dart';
import 'package:tom_travel_app/presentation/widgets/app_background.dart';

class FavorieteScreen extends StatefulWidget {
  const FavorieteScreen({super.key});

  @override
  State<FavorieteScreen> createState() => _FavorieteScreen(); 
}

class _FavorieteScreen extends State<FavorieteScreen> {
  int selectedTab = 0;

  final tabs = [
    "Hotels",
    "Destinations",
    "Restaurants",
    "Attractions"
  ];

  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            if (state is FavoritesError) {
              return Center(
                child: Text(state.message, style: TextStyle(color: Colors.white)),
              );
            }

            if (state is FavoritesLoaded) {
              return _buildMainUI(state.favorites);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  //====================================================
  //                     MAIN UI
  //====================================================

  Widget _buildMainUI(List<FavoriteModel> favorites) {
    final filtered = favorites.where((f) {
      switch (selectedTab) {
        case 0: return f.favorableType == "hotel";
        case 1: return f.favorableType == "destination";
        case 2: return f.favorableType == "restaurant";
        case 3: return f.favorableType == "attraction";
      }
      return false;
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 40),

          Text(
            "Favorites",
            style: AppTextStyles.heading.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),

          const SizedBox(height: 25),

          _buildScrollableTabs(),

          const SizedBox(height: 20),

          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Text(
                      "No Favorites Found",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : _buildList(filtered),
          ),
        ],
      ),
    );
  }

  //====================================================
  //!                SCROLLABLE TABS
  //====================================================

  Widget _buildScrollableTabs() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: tabs.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: _tabButton(tabs[i], selectedTab == i, () {
              setState(() => selectedTab = i);
            }),
          );
        },
      ),
    );
  }

  Widget _tabButton(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white,
            width: selected ? 2 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          text,
          style: AppTextStyles.heading.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: selected ? AppColors.navyBlue : Colors.white,
          ),
        ),
      ),
    );
  }

  //====================================================
  //!                    LIST VIEW
  //====================================================

  Widget _buildList(List<FavoriteModel> list) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: list.map((f) {
  final data = f.favorable ?? {};

  return Dismissible(
    key: ValueKey(f.id),
    direction: DismissDirection.endToStart,

    // تصميم الخلفية أثناء السحب
    background: Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(Icons.delete, color: Colors.white, size: 32),
    ),

    // عند الإفلات
    confirmDismiss: (_) async {
  final shouldDelete = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
            SizedBox(width: 10),
            Text("Confirm Delete"),
          ],
        ),
        content: const Text(
          "Are you sure you want to remove this from your favorites?",
          style: TextStyle(fontSize: 15),
        ),
        actionsPadding: const EdgeInsets.only(bottom: 12, right: 12),
        actions: [
          TextButton(
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Delete"),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
    },
  );

  if (shouldDelete == true) {
    // ignore: use_build_context_synchronously
    context.read<FavoritesCubit>().removeFavorite(f.id);
    return true; // احذف العنصر
  }

  return false; // لا تحذف
},


    // البطاقة الفعلية
    child: AnimatedOpacity(
      duration: const Duration(milliseconds: 450),
      opacity: 1,
      child: AnimatedSlide(
        offset: const Offset(0, 0.06),
        duration: const Duration(milliseconds: 450),
        child: _unifiedCard(
          image: data["image"] ?? "",
          title: data["name"] ?? "",
          rating: (data["average_rating"] ?? data["rating"] ?? "0").toString(),
          subtitle: _buildSubtitle(f.favorableType, data),
          description: data["description"] ?? "",
        ),
      ),
    ),
  );
}).toList(),

      ),
    );
  }

  //====================================================
  //!            UNIFIED CARD DESIGN
  //====================================================

  Widget _unifiedCard({
    required String image,
    required String title,
    required String rating,
    required String subtitle,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          // Image
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image(
                image: image.isNotEmpty
                    ? NetworkImage(image)
                    : const AssetImage("assets/images/default.png") as ImageProvider,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Text content
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navyBlue,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Subtitle (Country/City/Cuisine...)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // Rating
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/star_icon.svg",
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: AppTextStyles.heading.copyWith(
                          fontSize: 13,
                          color: AppColors.navyBlue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Description
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //====================================================
  //!             Subtitle logic per type
  //====================================================

  String _buildSubtitle(String type, Map<String, dynamic> data) {
    switch (type) {
      case "hotel":
        return "${data['destination']?['country']}, ${data['destination']?['name']}";
      case "destination":
        return data["country"] ?? "";
      case "restaurant":
        return data["cuisine"] ?? "Restaurant";
      case "attraction":
        return data["city"] ?? "Attraction";
      default:
        return "";
    }
  }
}

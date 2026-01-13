import 'package:flutter/material.dart';
import 'package:tom_travel_app/presentation/screens/explore/explore_screen.dart';
import 'package:tom_travel_app/presentation/screens/favoriete/favoriete_screen.dart';
import 'package:tom_travel_app/presentation/screens/mytrips/mytrips_screen.dart';
import 'package:tom_travel_app/presentation/screens/profile/profile_screen.dart';
import 'package:tom_travel_app/presentation/widgets/bottom_navigation_bar.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;


  final List<Widget> screens = [
    const ExploreScreen(),
    const MyTripsScreen(), 
    const FavorieteScreen(), 
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,

      body: screens[currentIndex],
      
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
      ),
    );
  }
}

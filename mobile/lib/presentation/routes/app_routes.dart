import 'package:flutter/material.dart';
import 'package:tom_travel_app/data/repositories/auth_repository.dart';
import 'package:tom_travel_app/presentation/screens/favoriete/favoriete_screen.dart';

import 'package:tom_travel_app/presentation/screens/home_layout.dart';
import 'package:tom_travel_app/presentation/screens/mytrips/mytrips_screen.dart';
import 'package:tom_travel_app/presentation/screens/profile/edit_user_info_screen.dart';
import 'package:tom_travel_app/presentation/screens/profile/profile_screen.dart';
import 'package:tom_travel_app/presentation/screens/splash/splash_screen.dart';
import 'package:tom_travel_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:tom_travel_app/presentation/screens/auth/login/login_screen.dart';
import 'package:tom_travel_app/presentation/screens/auth/signup/signup_screen.dart';

class AppRouter {
  final AuthRepository authRepository = AuthRepository();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen()); 

      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case '/home':
      return MaterialPageRoute(builder: (_) => const HomeLayout());
      
      case '/mytrips':
      return MaterialPageRoute(builder: (_) => const MyTripsScreen());

      case '/favorite':
        return MaterialPageRoute(builder: (_) => const FavorieteScreen());

      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case '/editprofile':
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("Route not found: ${settings.name}")),
          ),
        );
    }
  }
}

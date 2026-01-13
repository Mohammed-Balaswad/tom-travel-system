// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tom_travel_app/data/repositories/auth_repository.dart';
import 'package:tom_travel_app/data/repositories/destination_repository.dart';
import 'package:tom_travel_app/data/repositories/favorites_repository.dart';
import 'package:tom_travel_app/data/repositories/hotel_repository.dart';
import 'package:tom_travel_app/data/repositories/my_trips_repository.dart';
import 'package:tom_travel_app/data/repositories/search_repository.dart';

import 'package:tom_travel_app/logic/cubits/auth_cubit.dart';
import 'package:tom_travel_app/logic/cubits/destination_cubit.dart';
import 'package:tom_travel_app/logic/cubits/favorites_cubit.dart';
import 'package:tom_travel_app/logic/cubits/hotel_cubit.dart';
import 'package:tom_travel_app/logic/cubits/my_trips_cubit.dart';
import 'package:tom_travel_app/logic/cubits/search_cubit.dart';

import 'package:tom_travel_app/presentation/routes/app_routes.dart';

void main() {
  final authRepository = AuthRepository();
  final destinationRepository = DestinationRepository();
  final hotelRepository = HotelRepository();
  final searchRepository = SearchRepository();
  final myTripsRepository = MyTripsRepository();
  final favoritesrepository = FavoritesRepository();

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (_) => AuthCubit(authRepository)
            ),
            BlocProvider<DestinationCubit>(
              create: (_) => DestinationCubit(destinationRepository),
            ),
            BlocProvider<HotelCubit>(
              create: (_) => HotelCubit(hotelRepository),
            ),
            BlocProvider<SearchCubit>(
              create: (_) => SearchCubit(searchRepository),
            ),
            BlocProvider<MyTripsCubit>(
              create: (_) => MyTripsCubit(myTripsRepository),
            ),
            BlocProvider<FavoritesCubit>(
              create: (_) => FavoritesCubit(favoritesrepository),
            ),

          ],
          child: child!,
        );
      },
      child: TomTravelApp(appRouter: AppRouter()),
    ),
  );
}

class TomTravelApp extends StatelessWidget {
  final AppRouter _appRouter;

  const TomTravelApp({required AppRouter appRouter}) : _appRouter = appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tom Travel',
      onGenerateRoute: _appRouter.generateRoute,
      initialRoute: '/',
    );
  }
}

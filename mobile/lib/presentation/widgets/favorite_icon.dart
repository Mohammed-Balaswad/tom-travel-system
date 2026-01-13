// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tom_travel_app/logic/cubits/favorites_cubit.dart';
import 'package:tom_travel_app/logic/states/favorites-states.dart';

class FavoriteIcon extends StatelessWidget {
  final String type; // "hotel", "destination", "restaurant", "attraction"
  final int itemId;

  const FavoriteIcon({super.key, required this.type, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final favoritesCubit = context.read<FavoritesCubit>();

    return BlocSelector<FavoritesCubit, FavoritesState, bool>(
      selector: (state) {
        if (state is FavoritesLoaded) {
          return state.favorites.any(
            (f) => f.favorableType == type && f.favorableId == itemId,
          );
        }
        return false;
      },
      builder: (context, isFavorite) {
        return GestureDetector(
          onTap: () async {
            if (isFavorite) {
              await favoritesCubit.removeFavoriteByType(type, itemId);
            } else {
              await favoritesCubit.addFavorite(type, itemId);
            }
          },
          child: Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SvgPicture.asset(
                isFavorite
                    ? 'assets/icons/red_hart_icon.svg'
                    : 'assets/icons/white_hart_icon.svg',
              ),
            ),
          ),
        );
      },
    );
  }
}
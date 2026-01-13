// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tom_travel_app/data/repositories/favorites_repository.dart';
import 'package:tom_travel_app/logic/states/favorites-states.dart';


class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository repo;

  FavoritesCubit(this.repo) : super(FavoritesInitial());

  Future<void> fetchFavorites() async {
    emit(FavoritesLoading());
    try {
      final favorites = await repo.getFavorites();
      //print("Cubit fetched favorites count: ${favorites.length}");
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      print("Error in FavoritesCubit: $e");
      emit(FavoritesError(e.toString()));
    }
  } 

  Future<void> addFavorite(String type, int favorableId) async {
  try {
    await repo.addFavorite(type, favorableId);
    await fetchFavorites(); 
  } catch (e) {
    emit(FavoritesError(e.toString()));
  }
}

  Future<void> removeFavorite(int id) async {
    try {
      await repo.deleteFavorite(id);
      await fetchFavorites(); // إعادة تحميل القائمة
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  bool isFavorite(String type, int favorableId) { 
  if (state is! FavoritesLoaded) return false;

  return (state as FavoritesLoaded).favorites.any(
    (f) => f.favorableType == type && f.favorableId == favorableId,
  );
}

Future<void> removeFavoriteByType(String type, int favorableId) async {
  if (state is! FavoritesLoaded) return;

  final list = (state as FavoritesLoaded).favorites
      .where((f) => f.favorableType == type && f.favorableId == favorableId)
      .toList();

  if (list.isEmpty) return;

  await removeFavorite(list.first.id);
}
}
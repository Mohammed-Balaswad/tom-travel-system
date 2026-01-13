import 'package:tom_travel_app/core/network/api_endpoints.dart';
import 'package:tom_travel_app/core/network/dio_client.dart';

import '../models/favorite_model.dart';

class FavoritesRepository {
  final DioClient _client = DioClient();

  Future<List<FavoriteModel>> getFavorites() async {
    final response = await _client.get("/favorites");
   // print("Raw favorites response: ${response.data}");
    final List favorites = response.data['data'];
    return favorites.map((f) => FavoriteModel.fromJson(f)).toList();
  }

  Future<void> addFavorite(String type, int favorableId) async { 
  await _client.post("/favorites", data: {
    "favorable_type": type,   
    "favorable_id": favorableId,
  });
}

  Future<void> deleteFavorite(int id) async {
  await _client.delete(ApiEndpoints.deleteFavorite(id));
}

} 
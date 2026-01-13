import 'package:tom_travel_app/core/network/base_api.dart';
import 'package:tom_travel_app/data/models/search_result_model.dart';

class SearchRepository {
  final BaseApi _api = BaseApi();

  Future<List<SearchResultModel>> search(String q) async {
   final response = await _api.get('/search', query: {'q': q});
   
    final data = response.data['results'] as List<dynamic>? ?? [];

    return data.map((e) => SearchResultModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}

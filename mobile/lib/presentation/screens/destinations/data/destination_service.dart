import 'package:dio/dio.dart';
import 'package:tom_travel_app/core/network/api_endpoints.dart';
import 'package:tom_travel_app/core/network/base_api.dart';
import 'package:tom_travel_app/data/models/destination_model.dart';


class DestinationService extends BaseApi {
  Future<List<DestinationModel>> fetchAll() async {
    final Response response = await get(ApiEndpoints.destinations);

    if (response.statusCode == 200) {
      final data = response.data['data'] as List;
      return data.map((e) => DestinationModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch destinations");
    }
  }

  Future<DestinationModel> fetchById(int id) async {
    final Response response = await get("${ApiEndpoints.destinations}/$id");

    if (response.statusCode == 200) {
      return DestinationModel.fromJson(response.data['data']);
    } else {
      throw Exception("Failed to fetch destination details");
    }
  }
}

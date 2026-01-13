import 'package:tom_travel_app/data/models/destination_model.dart';
import 'package:tom_travel_app/core/network/dio_client.dart';

class DestinationRepository {
  final DioClient _client = DioClient();

  Future<List<DestinationModel>> getDestinations() async {
    final response = await _client.get("/destinations");

    final List data = response.data["data"];

    return data.map((json) => DestinationModel.fromJson(json)).toList();
  }


  Future<DestinationModel> getDestinationById(int id) async {
    final response = await _client.get("/destinations/$id");
    return DestinationModel.fromJson(response.data["data"]);
  }
  
}

import 'package:tom_travel_app/core/network/api_endpoints.dart';
import 'package:tom_travel_app/data/models/my_trips_model.dart';
import 'package:tom_travel_app/core/network/dio_client.dart';

class MyTripsRepository {
  final DioClient _client = DioClient();

  Future<MyTripsModel> getMyTrips() async {
  final response = await _client.get(ApiEndpoints.myTrips);
  
  return MyTripsModel.fromJson(response.data["data"]);
}
}
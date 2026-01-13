import 'package:tom_travel_app/data/models/hotel_model.dart';
import 'package:tom_travel_app/core/network/dio_client.dart';

class HotelRepository {
  final DioClient _client = DioClient();

  Future<List<HotelModel>> getHotels() async {
    final response = await _client.get("/hotels"); 

    final List data = response.data["data"];

    return data.map((json) => HotelModel.fromJson(json)).toList();
  }


  Future<HotelModel> getHotelById(int id) async {
    final response = await _client.get("/hotels/$id");
    
    return HotelModel.fromJson(response.data["data"]);
  }
  
}

import 'package:tom_travel_app/data/models/flight_booking_model.dart';
import 'package:tom_travel_app/data/models/hotel_booking_model.dart';

class MyTripsModel {
  final List<HotelBookingModel> hotelBookings;
  final List<FlightBookingModel> flightBookings;

  MyTripsModel({
    required this.hotelBookings,
    required this.flightBookings,
  });

  factory MyTripsModel.fromJson(Map<String, dynamic> json) {
    return MyTripsModel(
      hotelBookings: (json['hotel_bookings'] as List)
          .map((e) => HotelBookingModel.fromJson(e))
          .toList(),
          
      flightBookings: (json['flight_bookings'] as List)
          .map((e) => FlightBookingModel.fromJson(e))
          .toList(),
    );
  }
}

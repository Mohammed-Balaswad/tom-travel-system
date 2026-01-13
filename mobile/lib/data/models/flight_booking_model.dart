import 'flight_model.dart';
import 'user_model.dart';

class FlightBookingModel {
  final int id;
  final int userId;
  final int flightId;
  final String flightType;
  final String departureCity;
  final String arrivalCity;
  final String departureDate;
  final String? returnDate;
  final int passengers;
  final String? seatClass;
  final double totalPrice;
  final String status;
  final String paymentStatus;
  final FlightModel? flight;
  final UserModel? user;

  FlightBookingModel({
    required this.id,
    required this.userId,
    required this.flightId,
    required this.flightType,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureDate,
    this.returnDate,
    required this.passengers,
    this.seatClass,
    required this.totalPrice,
    required this.status,
    required this.paymentStatus,
    this.flight,
    this.user,
  }); 

  factory FlightBookingModel.fromJson(Map<String, dynamic> json) {
    return FlightBookingModel(
      id: json['id'],
      userId: json['user_id'],
      flightId: json['flight_id'],
      flightType: json['flight_type'] ?? 'one_way',
      departureCity: json['departure_city'],
      arrivalCity: json['arrival_city'],
      departureDate: json['departure_date'],
      returnDate: json['return_date'],
      passengers: json['passengers'] ?? 1,
      seatClass: json['seat_class'],
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      status: json['status'] ?? 'pending',
      paymentStatus: json['payment_status'] ?? 'unpaid',
      flight: (json['flight'] != null && json['flight'] is Map<String, dynamic>)
    ? FlightModel.fromJson(json['flight'] as Map<String, dynamic>)
    : null,
      user: (json['user'] != null && json['user'] is Map<String, dynamic>)
    ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
    : null,

    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "flight_id": flightId,
        "flight_type": flightType,
        "departure_city": departureCity,
        "arrival_city": arrivalCity,
        "departure_date": departureDate,
        "return_date": returnDate,
        "passengers": passengers,
        "seat_class": seatClass,
        "total_price": totalPrice,
        "status": status,
        "payment_status": paymentStatus,
        "flight": flight?.toJson(),
        "user": user?.toJson(),
      };
}

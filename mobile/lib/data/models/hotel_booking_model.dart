import 'hotel_model.dart';
import 'room_model.dart';
import 'user_model.dart';

class HotelBookingModel {
  final int id;
  final int userId;
  final int hotelId;
  final int? roomId;
  final String checkIn;
  final String checkOut;
  final int nights;
  final int roomsCount;
  final int adults;
  final int children;
  final int guestsTotal;
  final double totalPrice;
  final String status;
  final String paymentStatus;
  final HotelModel? hotel;
  final RoomModel? room;
  final UserModel? user;

  HotelBookingModel({
    required this.id,
    required this.userId,
    required this.hotelId,
    this.roomId,
    required this.checkIn,
    required this.checkOut,
    required this.nights,
    required this.roomsCount,
    required this.adults,
    required this.children,
    required this.guestsTotal,
    required this.totalPrice,
    required this.status,
    required this.paymentStatus,
    this.hotel,
    this.room,
    this.user,
  }); 

  factory HotelBookingModel.fromJson(Map<String, dynamic> json) {
    return HotelBookingModel(
      id: json['id'],
      userId: json['user_id'],
      hotelId: json['hotel_id'],
      roomId: json['room_id'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      nights: json['nights'],
      roomsCount: json['rooms_count'],
      adults: json['adults'],
      children: json['children'],
      guestsTotal: json['guests_total'],
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      status: json['status'] ?? 'pending',
      paymentStatus: json['payment_status'] ?? 'unpaid',
      hotel: (json['hotel'] != null && json['hotel'] is Map<String, dynamic>)
    ? HotelModel.fromJson(json['hotel'] as Map<String, dynamic>)
    : null,
      room: (json['room'] != null && json['room'] is Map<String, dynamic>)
    ? RoomModel.fromJson(json['room'] as Map<String, dynamic>)
    : null,
      user: (json['user'] != null && json['user'] is Map<String, dynamic>)
    ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
    : null,


    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "hotel_id": hotelId,
        "room_id": roomId,
        "check_in": checkIn,
        "check_out": checkOut,
        "nights": nights,
        "rooms_count": roomsCount,
        "adults": adults,
        "children": children,
        "guests_total": guestsTotal,
        "total_price": totalPrice,
        "status": status,
        "payment_status": paymentStatus,
        "hotel": hotel?.toJson(),
        "room": room?.toJson(),
        "user": user?.toJson(),
      };
}

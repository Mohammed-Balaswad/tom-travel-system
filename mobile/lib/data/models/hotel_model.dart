import 'room_model.dart';
import 'destination_model.dart';
import 'review_model.dart';

class HotelModel {
  final int id;
  final int destinationId;
  final String name;
  final String? description;
  final String? image;
  final String? location;
  final List<String>? amenities;
  final double averageRating;
  final DestinationModel destination;
  final List<RoomModel>? rooms;
  final List<ReviewModel>? reviews;

  HotelModel({
    required this.id,
    required this.destinationId,
    required this.name,
    this.description,
    this.image,
    this.location,
    this.amenities,
    required this.averageRating,
    required this.destination,
    this.rooms,
    this.reviews,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      destinationId: json['destination_id'],
      name: json['name'] ?? '',
      description: json['description'],
      image: json['image'],
      location: json['location'],
      amenities: json['amenities'] != null
          ? List<String>.from(json['amenities'])
          : null,
      averageRating: double.tryParse(json['average_rating'].toString()) ?? 0.0,

      destination: (json['destination'] != null && json['destination'] is Map<String, dynamic>)
    ? DestinationModel.fromJson(json['destination'] as Map<String, dynamic>)
    : DestinationModel(id: 0, name: '', country: '', averageRating: null), // أو قيمة افتراضية

      rooms: json['rooms'] != null
          ? List<RoomModel>.from(
              json['rooms'].map((x) => RoomModel.fromJson(x)))
          : null,
      reviews: json['reviews'] != null
          ? List<ReviewModel>.from(
              json['reviews'].map((x) => ReviewModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "destination_id": destinationId,
        "name": name,
        "description": description,
        "image": image,
        "location": location,
        "amenities": amenities,
        "average_rating": averageRating,
        "destination": destination.toJson(),
        "rooms": rooms?.map((x) => x.toJson()).toList(),
        "reviews": reviews?.map((x) => x.toJson()).toList(),
      };
}

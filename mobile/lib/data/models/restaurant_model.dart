import 'dish_model.dart';
import 'destination_model.dart';

class RestaurantModel {
  final int id;
  final int destinationId;
  final String name;
  final String? location;
  final String? description;
  final String? openHours;
  final String? image;
  final double averageRating;
  final String? createdAt;
  final String? updatedAt;
  final DestinationModel? destination;
  final List<DishModel>? dishes;

  RestaurantModel({
    required this.id,
    required this.destinationId,
    required this.name,
    this.location,
    this.description,
    this.openHours,
    this.image,
    required this.averageRating,
    this.createdAt,
    this.updatedAt,
    this.destination,
    this.dishes,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      destinationId: json['destination_id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      openHours: json['open_hours'],
      image: json['image'],
      averageRating: double.tryParse(json['average_rating'].toString()) ?? 0.0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      destination: json['destination'] != null
          ? DestinationModel.fromJson(json['destination'])
          : null,
      dishes: json['dishes'] != null
          ? (json['dishes'] as List)
              .map((d) => DishModel.fromJson(d))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "destination_id": destinationId,
        "name": name,
        "location": location,
        "description": description,
        "open_hours": openHours,
        "image": image,
        "average_rating": averageRating,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "destination": destination?.toJson(),
        "dishes": dishes?.map((d) => d.toJson()).toList(),
      };
}

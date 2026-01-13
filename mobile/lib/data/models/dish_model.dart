import 'restaurant_model.dart';

class DishModel {
  final int id;
  final int restaurantId;
  final String? category;
  final String name;
  final double price;
  final double averageRating;
  final String? description;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final RestaurantModel? restaurant;

  DishModel({
    required this.id,
    required this.restaurantId,
    this.category,
    required this.name,
    required this.price,
    required this.averageRating,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.restaurant,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      id: json['id'],
      restaurantId: json['restaurant_id'],
      category: json['category'],
      name: json['name'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      averageRating: double.tryParse(json['average_rating'].toString()) ?? 0.0,
      description: json['description'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      restaurant: json['restaurant'] != null
          ? RestaurantModel.fromJson(json['restaurant'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurantId,
        "category": category,
        "name": name,
        "price": price,
        "average_rating": averageRating,
        "description": description,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "restaurant": restaurant?.toJson(),
      };
}

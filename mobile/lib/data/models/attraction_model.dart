import 'destination_model.dart';
import 'attraction_image_model.dart';

class AttractionModel {
  final int id;
  final int destinationId;
  final String name;
  final String? location;
  final String? description;
  final String? openHours;
  final double averageRating;
  final String? image;
  final List<String>? gallery;
  final String? createdAt;
  final String? updatedAt;
  final DestinationModel? destination;
  final List<AttractionImageModel>? images;

  AttractionModel({
    required this.id,
    required this.destinationId,
    required this.name,
    this.location,
    this.description,
    this.openHours,
    required this.averageRating,
    this.image,
    this.gallery,
    this.createdAt,
    this.updatedAt,
    this.destination,
    this.images,
  });

  factory AttractionModel.fromJson(Map<String, dynamic> json) {
    return AttractionModel(
      id: json['id'],
      destinationId: json['destination_id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      openHours: json['open_hours'],
      averageRating: double.tryParse(json['average_rating'].toString()) ?? 0.0,
      image: json['image'],
      gallery: json['gallery'] != null
          ? List<String>.from(json['gallery'])
          : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      destination: json['destination'] != null
          ? DestinationModel.fromJson(json['destination'])
          : null,
      images: json['images'] != null
          ? (json['images'] as List)
              .map((img) => AttractionImageModel.fromJson(img))
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
        "average_rating": averageRating,
        "image": image,
        "gallery": gallery,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "destination": destination?.toJson(),
        "images": images?.map((i) => i.toJson()).toList(),
      };
}

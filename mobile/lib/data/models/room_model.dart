class RoomModel {
  final int id;
  final int hotelId;
  final String type;
  final int capacity;
  final String? size;
  final double pricePerNight;
  final List<String>? features;
  final String? description;
  final bool isAvailable;

  RoomModel({
    required this.id,
    required this.hotelId,
    required this.type,
    required this.capacity,
    this.size,
    required this.pricePerNight,
    this.features,
    this.description,
    required this.isAvailable,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      hotelId: json['hotel_id'],
      type: json['type'],
      capacity: json['capacity'],
      size: json['size'],
      pricePerNight:
          double.tryParse(json['price_per_night'].toString()) ?? 0.0,
      features: (json['features'] != null && json['features'] is List)
    ? List<String>.from(json['features'])
    : null,
      description: json['description'],
      isAvailable: json['is_available'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "hotel_id": hotelId,
        "type": type,
        "capacity": capacity,
        "size": size,
        "price_per_night": pricePerNight,
        "features": features,
        "description": description,
        "is_available": isAvailable,
      };
}

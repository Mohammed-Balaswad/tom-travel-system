class DestinationModel {
  final int id;
  final String name;
  final String country;
  final String? description;
  final String? image;
  final double? averageRating;
  final String? category;

  DestinationModel({
    required this.id,
    required this.name,
    required this.country,
    this.description,
    this.image,
    required this.averageRating,
    this.category,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      description: json['description'],
      image: json['image'],
      averageRating: double.tryParse(json['average_rating'].toString()) ?? 0.0,
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "description": description,
        "image": image,
        "average_rating": averageRating,
        "category": category,
      };
}

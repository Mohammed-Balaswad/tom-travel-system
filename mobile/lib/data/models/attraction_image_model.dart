class AttractionImageModel {
  final int id;
  final int attractionId;
  final String imageUrl;
  final String? caption;
  final String? createdAt;

  AttractionImageModel({
    required this.id,
    required this.attractionId,
    required this.imageUrl,
    this.caption,
    this.createdAt,
  });

  factory AttractionImageModel.fromJson(Map<String, dynamic> json) {
    return AttractionImageModel(
      id: json['id'],
      attractionId: json['attraction_id'],
      imageUrl: json['image_url'],
      caption: json['caption'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "attraction_id": attractionId,
        "image_url": imageUrl,
        "caption": caption,
        "created_at": createdAt,
      };
}

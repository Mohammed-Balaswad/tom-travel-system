class SearchResultModel {
  final String type; // destination / hotel
  final int id;
  final String title;
  final String? subtitle;
  final String? image;

  SearchResultModel({
    required this.type,
    required this.id,
    required this.title,
    this.subtitle,
    this.image,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      id: json['id'] as int,
      type: json['type'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      image: json['image'] as String?,
    );
  }
}

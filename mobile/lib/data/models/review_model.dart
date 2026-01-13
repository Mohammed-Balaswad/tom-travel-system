import 'user_model.dart';

class ReviewModel {
  final int id;
  final int userId;
  final String reviewableType;
  final int reviewableId;
  final double rating;
  final String? comment;
  final String? createdAt;
  final UserModel? user;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.reviewableType,
    required this.reviewableId,
    required this.rating,
    this.comment,
    this.createdAt,
    this.user,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      userId: json['user_id'],
      reviewableType: json['reviewable_type'],
      reviewableId: json['reviewable_id'],
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      comment: json['comment'],
      createdAt: json['created_at'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "reviewable_type": reviewableType,
        "reviewable_id": reviewableId,
        "rating": rating,
        "comment": comment,
        "created_at": createdAt,
        "user": user?.toJson(),
      };
}

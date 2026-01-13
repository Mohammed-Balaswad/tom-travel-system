import 'user_model.dart';

class FavoriteModel {
  final int id;
  final int userId;
  final String favorableType;
  final int favorableId;
  final String? createdAt;
  final UserModel? user;
  final Map<String, dynamic>? favorable; 

  FavoriteModel({
    required this.id,
    required this.userId,
    required this.favorableType,
    required this.favorableId,
    this.createdAt,
    this.user,
    this.favorable,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      userId: json['user_id'],
      favorableType: json['favorable_type'],
      favorableId: json['favorable_id'],
      createdAt: json['created_at'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      favorable: json['favorable'], // يخزن الـ object كما هو
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "favorable_type": favorableType,
        "favorable_id": favorableId,
        "created_at": createdAt,
        "user": user?.toJson(),
        "favorable": favorable,
      };
}
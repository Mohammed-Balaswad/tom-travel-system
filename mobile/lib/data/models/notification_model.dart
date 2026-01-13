import 'user_model.dart';

class NotificationModel {
  final int id;
  final int userId;
  final String type;
  final Map<String, dynamic>? payload;
  final bool isRead;
  final String? createdAt;
  final UserModel? user;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    this.payload,
    required this.isRead,
    this.createdAt,
    this.user,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'] ?? '',
      payload: json['payload'],
      isRead: json['is_read'] ?? false,
      createdAt: json['created_at'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "payload": payload,
        "is_read": isRead,
        "created_at": createdAt,
        "user": user?.toJson(),
      };
}

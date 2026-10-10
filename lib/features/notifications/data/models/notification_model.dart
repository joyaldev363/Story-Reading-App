import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.message,
    required super.timestamp,
    super.isRead,
    required super.category,
    super.storyId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool? ?? false,
      category: NotificationCategory.values.firstWhere(
        (c) => c.name == (json['category'] as String? ?? 'system'),
        orElse: () => NotificationCategory.system,
      ),
      storyId: json['storyId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'category': category.name,
      'storyId': storyId,
    };
  }
}

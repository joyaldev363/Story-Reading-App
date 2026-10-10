import '../../domain/entities/notification_entity.dart';
import '../models/notification_model.dart';

abstract class NotificationsLocalDataSource {
  Future<List<NotificationModel>> getNotifications();
}

class NotificationsLocalDataSourceImpl implements NotificationsLocalDataSource {
  const NotificationsLocalDataSourceImpl();

  @override
  Future<List<NotificationModel>> getNotifications() async {
    // Simulate slight network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final now = DateTime.now();

    return [
      NotificationModel(
        id: 'notif_1',
        title: 'New Story Added! 📖',
        message: 'Discover "The Magic Treehouse Adventure" in your recommendations today.',
        timestamp: now.subtract(const Duration(minutes: 15)),
        isRead: false,
        category: NotificationCategory.story,
        storyId: 'story_banner_1',
      ),
      NotificationModel(
        id: 'notif_2',
        title: 'Daily Streak 🔥',
        message: 'You read for 3 days in a row! Keep up the great reading habit.',
        timestamp: now.subtract(const Duration(hours: 2)),
        isRead: false,
        category: NotificationCategory.streak,
      ),
      NotificationModel(
        id: 'notif_3',
        title: 'Badge Unlocked 🏆',
        message: 'Congratulations! You earned the "Night Owl Reader" badge.',
        timestamp: now.subtract(const Duration(hours: 18)),
        isRead: true,
        category: NotificationCategory.reward,
      ),
      NotificationModel(
        id: 'notif_4',
        title: 'Bedtime Recommendation 🌙',
        message: '"The Brave Little Fox" is perfect for tonight\'s bedtime story.',
        timestamp: now.subtract(const Duration(days: 1)),
        isRead: true,
        category: NotificationCategory.story,
        storyId: 'story_rec_1',
      ),
      NotificationModel(
        id: 'notif_5',
        title: 'App Update Ready 🚀',
        message: 'Storyly v1.2 brings smoother audio playback and new offline stories.',
        timestamp: now.subtract(const Duration(days: 2)),
        isRead: true,
        category: NotificationCategory.system,
      ),
    ];
  }
}

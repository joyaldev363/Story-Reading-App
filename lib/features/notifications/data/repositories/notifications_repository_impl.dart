import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_datasource.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsLocalDataSource dataSource;
  List<NotificationEntity>? _cachedNotifications;

  NotificationsRepositoryImpl({required this.dataSource});

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    if (_cachedNotifications == null) {
      _cachedNotifications = await dataSource.getNotifications();
    }
    return List.unmodifiable(_cachedNotifications!);
  }

  @override
  Future<void> markAsRead(String id) async {
    if (_cachedNotifications == null) return;
    _cachedNotifications = _cachedNotifications!.map((item) {
      if (item.id == id) {
        return item.copyWith(isRead: true);
      }
      return item;
    }).toList();
  }

  @override
  Future<void> markAllAsRead() async {
    if (_cachedNotifications == null) return;
    _cachedNotifications = _cachedNotifications!.map((item) {
      return item.copyWith(isRead: true);
    }).toList();
  }

  @override
  Future<void> deleteNotification(String id) async {
    if (_cachedNotifications == null) return;
    _cachedNotifications = _cachedNotifications!.where((item) => item.id != id).toList();
  }

  @override
  Future<void> clearAll() async {
    _cachedNotifications = [];
  }
}

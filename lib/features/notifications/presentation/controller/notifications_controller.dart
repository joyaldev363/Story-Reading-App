import 'package:flutter/material.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notifications_repository.dart';

class NotificationsController extends ChangeNotifier {
  final NotificationsRepository repository;

  NotificationsController({required this.repository});

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<NotificationEntity> _notifications = [];
  List<NotificationEntity> get notifications => _notifications;

  NotificationCategory _selectedCategory = NotificationCategory.all;
  NotificationCategory get selectedCategory => _selectedCategory;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  List<NotificationEntity> get filteredNotifications {
    if (_selectedCategory == NotificationCategory.all) {
      return _notifications;
    }
    return _notifications
        .where((n) => n.category == _selectedCategory)
        .toList();
  }

  Future<void> loadNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      _notifications = await repository.getNotifications();
    } catch (_) {
      _notifications = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(NotificationCategory category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> markAsRead(String id) async {
    await repository.markAsRead(id);
    _notifications = _notifications.map((n) {
      if (n.id == id) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();
    notifyListeners();
  }

  Future<void> markAllAsRead() async {
    await repository.markAllAsRead();
    _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
    notifyListeners();
  }

  Future<void> deleteNotification(String id) async {
    await repository.deleteNotification(id);
    _notifications = _notifications.where((n) => n.id != id).toList();
    notifyListeners();
  }

  Future<void> clearAll() async {
    await repository.clearAll();
    _notifications = [];
    notifyListeners();
  }
}

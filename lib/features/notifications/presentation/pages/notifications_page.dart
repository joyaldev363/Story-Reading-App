import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import 'package:storyly/features/notifications/data/datasources/notifications_datasource.dart';
import 'package:storyly/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:storyly/features/notifications/domain/usecases/get_notifications.dart';
import 'package:storyly/features/notifications/presentation/controller/notifications_controller.dart';
import 'package:storyly/features/notifications/presentation/widgets/notification_filter_chips.dart';
import 'package:storyly/features/notifications/presentation/widgets/notification_tile.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final NotificationsController _controller;

  @override
  void initState() {
    super.initState();
    const dataSource = NotificationsLocalDataSourceImpl();
    final repository = NotificationsRepositoryImpl(dataSource: dataSource);
    _controller = NotificationsController(repository: repository);
    _controller.loadNotifications();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundCream,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.navyBlue, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final unread = _controller.unreadCount;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    color: AppColors.navyBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                if (unread > 0) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.accentGold,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$unread',
                      style: const TextStyle(
                        color: AppColors.navyBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
        centerTitle: false,
        actions: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              if (_controller.unreadCount == 0) return const SizedBox.shrink();
              return TextButton(
                onPressed: () => _controller.markAllAsRead(),
                child: const Text(
                  'Mark all read',
                  style: TextStyle(
                    color: AppColors.accentGold,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (_controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.navyBlue),
            );
          }

          final notifications = _controller.filteredNotifications;

          return Column(
            children: [
              const SizedBox(height: 8),
              // Filter Chips
              NotificationFilterChips(
                selectedCategory: _controller.selectedCategory,
                onCategorySelected: (cat) => _controller.selectCategory(cat),
              ),

              const SizedBox(height: 16),

              // Notifications List or Empty State
              Expanded(
                child: notifications.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        itemCount: notifications.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = notifications[index];
                          return NotificationTile(
                            notification: item,
                            onTap: () => _controller.markAsRead(item.id),
                            onDelete: () {
                              _controller.deleteNotification(item.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Notification removed'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.accentGold.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_off_outlined,
                size: 48,
                color: AppColors.accentGold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.navyBlue,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You are all caught up! Check back later for new story updates and reading achievements.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.subtitleSlate,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

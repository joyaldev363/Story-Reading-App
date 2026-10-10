import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final bool hasUnreadNotifications;

  const HomeHeader({
    super.key,
    this.onNotificationTap,
    this.onProfileTap,
    this.hasUnreadNotifications = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & App Name
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.accentGold.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.accentGold,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Storyly',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navyBlue,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'Read • Listen • Learn',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.subtitleSlate,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Actions: Notification & Profile Avatar
          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: onNotificationTap,
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.navyBlue,
                      size: 26,
                    ),
                  ),
                  if (hasUnreadNotifications)
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

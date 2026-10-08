import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class SavedHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMoreTap;

  const SavedHeader({
    super.key,
    this.onNotificationTap,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Title and Subtitle
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saved',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navyBlue,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Your saved stories',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.subtitleSlate,
                ),
              ),
            ],
          ),

          // Right: Bell notification with badge & More Vert
          Row(
            children: [
              GestureDetector(
                onTap: onNotificationTap,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.navyBlue,
                        size: 28,
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF5252),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: AppColors.navyBlue,
                  size: 26,
                ),
                onPressed: onMoreTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

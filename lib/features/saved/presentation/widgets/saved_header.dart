import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class SavedHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMoreTap;

  const SavedHeader({super.key, this.onNotificationTap, this.onMoreTap});

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
            ],
          ),

          // Right: Bell notification with badge & More Vert
          Row(
            children: [
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

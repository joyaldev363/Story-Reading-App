import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final VoidCallback? onSettingsTap;

  const ProfileHeader({
    super.key,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navyBlue,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Your account details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.subtitleSlate,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.navyBlue,
              size: 26,
            ),
            onPressed: onSettingsTap,
          ),
        ],
      ),
    );
  }
}

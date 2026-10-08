import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/profile.dart';
import 'profile_setting_tile.dart';

class PreferencesSection extends StatelessWidget {
  final ProfileEntity profile;
  final VoidCallback onLanguageTap;
  final VoidCallback onNotificationsTap;
  final VoidCallback onAppearanceTap;

  const PreferencesSection({
    super.key,
    required this.profile,
    required this.onLanguageTap,
    required this.onNotificationsTap,
    required this.onAppearanceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Preferences',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.navyBlue,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                ProfileSettingTile(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  subtitle: profile.languageLabel,
                  onTap: onLanguageTap,
                  showDivider: true,
                ),
                ProfileSettingTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  subtitle: 'Manage your reading reminders',
                  onTap: onNotificationsTap,
                  showDivider: true,
                ),
                ProfileSettingTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Appearance',
                  subtitle: profile.appearanceMode,
                  onTap: onAppearanceTap,
                  showDivider: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

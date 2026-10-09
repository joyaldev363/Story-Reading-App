import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import 'profile_setting_tile.dart';

class AccountSection extends StatelessWidget {
  final VoidCallback onEditProfileTap;
  final VoidCallback onPrivacyTap;
  final VoidCallback onHelpTap;
  final VoidCallback onAboutTap;

  const AccountSection({
    super.key,
    required this.onEditProfileTap,
    required this.onPrivacyTap,
    required this.onHelpTap,
    required this.onAboutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.navyBlue,
            ),
          ),
          const SizedBox(height: 12),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ProfileSettingTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Edit Profile',
                  subtitle: 'Update your name, photo and details',
                  onTap: onEditProfileTap,
                  showDivider: true,
                ),
                ProfileSettingTile(
                  icon: Icons.lock_outline_rounded,
                  title: 'Privacy & Security',
                  subtitle: 'Manage your data and privacy',
                  onTap: onPrivacyTap,
                  showDivider: true,
                ),
                ProfileSettingTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Help & Support',
                  subtitle: 'Get help or contact us',
                  onTap: onHelpTap,
                  showDivider: true,
                ),
                ProfileSettingTile(
                  icon: Icons.info_outline_rounded,
                  title: 'About Storyly',
                  subtitle: 'App version, terms and more',
                  onTap: onAboutTap,
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

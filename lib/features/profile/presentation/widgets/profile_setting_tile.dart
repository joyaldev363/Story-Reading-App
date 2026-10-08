import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class ProfileSettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool showDivider;

  const ProfileSettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.navyBlue,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navyBlue,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF718096),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                trailing ??
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFFA0AEC0),
                      size: 22,
                    ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.only(left: 56.0, right: 16.0),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFF1F5F9),
            ),
          ),
      ],
    );
  }
}

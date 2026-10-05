import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo/Logo.png',
      width: 220,
      height: 220,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accentGold.withValues(alpha: 0.15),
          ),
          child: const Center(
            child: Icon(
              Icons.auto_stories_rounded,
              size: 90,
              color: AppColors.navyBlue,
            ),
          ),
        );
      },
    );
  }
}

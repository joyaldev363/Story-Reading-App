import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class SplashTagline extends StatelessWidget {
  const SplashTagline({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Stories in Two Worlds',
      style: TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w600,
        color: AppColors.navyBlue.withValues(alpha: 0.9),
        letterSpacing: 0.5,
      ),
    );
  }
}

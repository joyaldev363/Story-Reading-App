import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class OnboardingIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const OnboardingIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) {
          final isSelected = index == currentIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            height: 10.0,
            width: isSelected ? 12.0 : 10.0,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.accentGold
                  : AppColors.progressTrack,
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}

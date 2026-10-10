import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationFilterChips extends StatelessWidget {
  final NotificationCategory selectedCategory;
  final ValueChanged<NotificationCategory> onCategorySelected;

  const NotificationFilterChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'label': 'All', 'value': NotificationCategory.all},
      {'label': 'Stories', 'value': NotificationCategory.story},
      {'label': 'Streaks', 'value': NotificationCategory.streak},
      {'label': 'Rewards', 'value': NotificationCategory.reward},
      {'label': 'System', 'value': NotificationCategory.system},
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final categoryValue = cat['value'] as NotificationCategory;
          final isSelected = selectedCategory == categoryValue;

          return GestureDetector(
            onTap: () => onCategorySelected(categoryValue),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.navyBlue : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.navyBlue
                      : AppColors.subtitleSlate.withOpacity(0.2),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.navyBlue.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                cat['label'] as String,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.subtitleSlate,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/category.dart';

class CategoryItemWidget extends StatelessWidget {
  final CategoryEntity category;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryItemWidget({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: category.backgroundColor,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(
                        color: AppColors.navyBlue,
                        width: 2.5,
                      )
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? AppColors.navyBlue.withOpacity(0.2)
                        : category.backgroundColor.withOpacity(0.5),
                    blurRadius: isSelected ? 10 : 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                category.icon,
                color: category.iconColor,
                size: 26,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? AppColors.navyBlue : AppColors.navyBlue.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

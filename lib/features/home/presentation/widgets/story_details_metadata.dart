import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/story.dart';

class StoryDetailsMetadataWidget extends StatelessWidget {
  final StoryEntity story;

  const StoryDetailsMetadataWidget({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title on left, Star Rating on right
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                story.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.navyBlue,
                  letterSpacing: -0.4,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                const Icon(Icons.star_rounded, size: 20, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${story.rating} (${story.reviewCount})',
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 4),

        // Subtitle line (Badge Tag / Category • Read Time)
        Text(
          '${story.badgeTag ?? "Moral Story"} • ${story.readTime}',
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 14),

        // Category Tag Chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildTagChip(
              Icons.pets_rounded,
              'Animals',
              const Color(0xFFE8F5E9),
              const Color(0xFF2E7D32),
            ),
            _buildTagChip(
              Icons.menu_book_rounded,
              'Bilingual',
              const Color(0xFFEEF2FF),
              const Color(0xFF4F46E5),
            ),
            _buildTagChip(
              Icons.eco_rounded,
              'Easy Read',
              const Color(0xFFFFF8E1),
              const Color(0xFFD97706),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTagChip(
    IconData icon,
    String label,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

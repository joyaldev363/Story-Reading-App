import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/story.dart';
import 'recommended_story_card.dart';

class RecommendedSectionWidget extends StatelessWidget {
  final List<StoryEntity> stories;
  final ValueChanged<StoryEntity>? onStoryTap;
  final ValueChanged<StoryEntity>? onFavoriteTap;
  final VoidCallback? onSeeAllTap;

  const RecommendedSectionWidget({
    super.key,
    required this.stories,
    this.onStoryTap,
    this.onFavoriteTap,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recommended for You',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navyBlue,
                ),
              ),
              GestureDetector(
                onTap: onSeeAllTap,
                child: const Row(
                  children: [
                    Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6C63FF),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: Color(0xFF6C63FF),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Cards List
          ...stories.map(
            (story) => RecommendedStoryCardWidget(
              story: story,
              onTap: () => onStoryTap?.call(story),
              onFavoriteTap: () => onFavoriteTap?.call(story),
            ),
          ),
        ],
      ),
    );
  }
}

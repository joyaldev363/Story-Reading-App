import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/story.dart';

class RecommendedStoryCardWidget extends StatelessWidget {
  final StoryEntity story;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const RecommendedStoryCardWidget({
    super.key,
    required this.story,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image Container with Heart Favorite Button
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    gradient: LinearGradient(
                      colors: _getCardGradient(story.id),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      _getCardIcon(story.id),
                      size: 64,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),

                // Save Bookmark Button
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white.withOpacity(0.85),
                      child: Icon(
                        story.isFavorite ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                        color: story.isFavorite ? const Color(0xFF635BFF) : AppColors.navyBlue,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Details
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Rating/Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        story.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navyBlue,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                          const SizedBox(width: 3),
                          Text(
                            '${story.rating} (${story.reviewCount})',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.subtitleSlate,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.access_time_rounded, size: 14, color: AppColors.subtitleSlate),
                          const SizedBox(width: 3),
                          Text(
                            story.readTime,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.subtitleSlate,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Language Label
                  Row(
                    children: [
                      const Icon(Icons.menu_book_rounded, size: 14, color: AppColors.subtitleSlate),
                      const SizedBox(width: 4),
                      Text(
                        story.languageLabel,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.subtitleSlate,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Description Excerpt
                  Text(
                    story.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.subtitleSlate.withOpacity(0.9),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getCardGradient(String id) {
    if (id.contains('1')) {
      return const [Color(0xFF81C784), Color(0xFF388E3C)]; // Soft nature green
    } else if (id.contains('2')) {
      return const [Color(0xFF3F51B5), Color(0xFF1A237E)]; // Night moon blue
    } else {
      return const [Color(0xFF4FC3F7), Color(0xFF0288D1)]; // Ocean beach blue
    }
  }

  IconData _getCardIcon(String id) {
    if (id.contains('1')) {
      return Icons.pets_rounded;
    } else if (id.contains('2')) {
      return Icons.nightlight_round;
    } else {
      return Icons.wb_sunny_rounded;
    }
  }
}

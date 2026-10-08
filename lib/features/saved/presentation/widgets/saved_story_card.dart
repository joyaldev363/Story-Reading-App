import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/saved_story.dart';

class SavedStoryCard extends StatelessWidget {
  final SavedStory story;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;

  const SavedStoryCard({
    super.key,
    required this.story,
    this.onTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Image Banner with Bookmark Badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: SizedBox(
                      height: 145,
                      width: double.infinity,
                      child: Image.asset(
                        story.coverUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Beautiful Fallback Gradient if asset not present
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: _getStoryGradient(story.id),
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.auto_stories_rounded,
                                color: Colors.white.withOpacity(0.8),
                                size: 48,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Top Right Bookmark Circular Button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: onBookmarkTap,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          story.isSaved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_outline_rounded,
                          color: const Color(0xFF635BFF),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Bottom Details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title, Rating & Time
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            story.title,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: AppColors.navyBlue,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Rating
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFFFB800),
                              size: 18,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${story.rating} (${story.reviewCount})',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF5A6679),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 12),

                        // Time
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              color: Color(0xFF8A94A6),
                              size: 16,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              story.readTime,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF5A6679),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Language indicator
                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          color: Color(0xFF8A94A6),
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          story.languageLabel,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6E7C91),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Description
                    Text(
                      story.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF6E7C91),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> _getStoryGradient(String storyId) {
    switch (storyId) {
      case 'saved_1':
        return [const Color(0xFF2B5876), const Color(0xFF4E4376)];
      case 'saved_2':
        return [const Color(0xFF141E30), const Color(0xFF243B55)];
      case 'saved_3':
        return [const Color(0xFF11998E), const Color(0xFF38EF7D)];
      case 'saved_4':
        return [const Color(0xFFFF9966), const Color(0xFFFF5E62)];
      default:
        return [const Color(0xFF5C6BC0), const Color(0xFF3F51B5)];
    }
  }
}

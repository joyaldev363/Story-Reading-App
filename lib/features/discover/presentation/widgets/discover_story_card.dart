import 'package:flutter/material.dart';
import '../../domain/entities/discover_story.dart';

class DiscoverStoryCard extends StatelessWidget {
  final DiscoverStory story;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const DiscoverStoryCard({
    super.key,
    required this.story,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24.0),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Image Container
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Stack(
                  children: [
                    _buildCoverImage(story),
                    // Save Bookmark Button
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: onFavoriteTap,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            story.isFavorite
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            size: 20,
                            color: story.isFavorite
                                ? const Color(0xFF635BFF)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content Details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Rating/Time Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            story.title,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: Color(0xFFF59E0B),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${story.rating} (${story.reviewCount})',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF475569),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.access_time_rounded,
                              size: 16,
                              color: Color(0xFF64748B),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              story.readTime,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Language Tag
                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 14,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          story.languageLabel,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Description & Action Arrow Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            story.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                              height: 1.35,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEEF2FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                            color: Color(0xFF6366F1),
                          ),
                        ),
                      ],
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

  Widget _buildCoverImage(DiscoverStory story) {
    // Generate fallback gradient illustrations according to story ID / title
    Gradient gradient;
    IconData iconData;
    List<Color> colors;

    if (story.title.contains('Dog')) {
      colors = [
        const Color(0xFF7C2D12),
        const Color(0xFFD97706),
        const Color(0xFF15803D),
      ];
      iconData = Icons.pets_rounded;
    } else if (story.title.contains('Moon')) {
      colors = [
        const Color(0xFF090D16),
        const Color(0xFF1E1B4B),
        const Color(0xFF312E81),
      ];
      iconData = Icons.nightlight_round;
    } else if (story.title.contains('Girl')) {
      colors = [
        const Color(0xFF064E3B),
        const Color(0xFF047857),
        const Color(0xFF059669),
      ];
      iconData = Icons.nature_people_rounded;
    } else {
      colors = [
        const Color(0xFF9A3412),
        const Color(0xFFEA580C),
        const Color(0xFFF97316),
      ];
      iconData = Icons.forest_rounded;
    }

    gradient = LinearGradient(
      colors: colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background graphic artwork pattern
          Center(
            child: Icon(
              iconData,
              size: 72,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.35),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

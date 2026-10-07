import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/story.dart';

class StoryBannerWidget extends StatelessWidget {
  final List<StoryEntity> banners;
  final int activeIndex;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<StoryEntity>? onReadStoryTap;

  const StoryBannerWidget({
    super.key,
    required this.banners,
    required this.activeIndex,
    required this.onPageChanged,
    this.onReadStoryTap,
  });

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              itemCount: banners.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                final story = banners[index];
                return _buildBannerCard(context, story);
              },
            ),
          ),
          const SizedBox(height: 12),

          // Pagination Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(banners.length > 1 ? banners.length : 4, (
              index,
            ) {
              final isCurrent =
                  index ==
                  (activeIndex % (banners.isNotEmpty ? banners.length : 1));
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: isCurrent ? 10 : 8,
                height: isCurrent ? 10 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent
                      ? AppColors.navyBlue
                      : AppColors.subtitleSlate.withOpacity(0.3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCard(BuildContext context, StoryEntity story) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: const LinearGradient(
          colors: [Color(0xFF1B2A4A), Color(0xFF2C3E65)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B2A4A).withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Fox Illustration Placeholder / Image Gradient
          Positioned(
            right: -10,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
              ),
              child: Container(
                width: 160,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.shade400.withOpacity(0.85),
                      Colors.amber.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.pets_rounded,
                    size: 80,
                    color: Colors.white24,
                  ),
                ),
              ),
            ),
          ),

          // Content Overlay
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentGold,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: AppColors.navyBlue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        story.badgeTag ?? 'Story of the Day',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navyBlue,
                        ),
                      ),
                    ],
                  ),
                ),

                // Title & Subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 180,
                      child: Text(
                        story.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                    ),
                  ],
                ),

                // Specs & CTA Button
                // Row(
                //   children: [
                //     Row(
                //       children: [
                //         const Icon(Icons.menu_book_rounded, size: 14, color: Colors.white70),
                //         const SizedBox(width: 4),
                //         Text(
                //           story.languageLabel,
                //           style: const TextStyle(fontSize: 11, color: Colors.white70),
                //         ),
                //         const SizedBox(width: 8),
                //         const Icon(Icons.access_time_rounded, size: 14, color: Colors.white70),
                //         const SizedBox(width: 4),
                //         Text(
                //           story.readTime,
                //           style: const TextStyle(fontSize: 11, color: Colors.white70),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),

                // Read Story Button
                ElevatedButton(
                  onPressed: () => onReadStoryTap?.call(story),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Read Story',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward_rounded, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

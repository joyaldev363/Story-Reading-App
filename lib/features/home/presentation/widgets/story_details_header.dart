import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/story.dart';

class StoryDetailsHeaderWidget extends StatelessWidget {
  final StoryEntity story;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;

  const StoryDetailsHeaderWidget({
    super.key,
    required this.story,
    required this.isBookmarked,
    required this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        // Top Cover Artwork Image with Fallback Gradient
        Container(
          height: 230 + topPadding,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
            child: _buildCoverContent(story),
          ),
        ),

        // Navigation Buttons Overlay
        Positioned(
          top: topPadding + 10,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white.withOpacity(0.9),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.navyBlue,
                    size: 18,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // Bookmark Save Button
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white.withOpacity(0.9),
                child: IconButton(
                  icon: Icon(
                    isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_outline_rounded,
                    color: isBookmarked
                        ? const Color(0xFF635BFF)
                        : AppColors.navyBlue,
                    size: 20,
                  ),
                  onPressed: onBookmarkTap,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCoverContent(StoryEntity story) {
    if (story.coverUrl.startsWith('http://') ||
        story.coverUrl.startsWith('https://')) {
      return Image.network(
        story.coverUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildFallbackGradient(story.id),
      );
    }
    if (story.coverUrl.isNotEmpty) {
      return Image.asset(
        story.coverUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildFallbackGradient(story.id),
      );
    }
    return _buildFallbackGradient(story.id);
  }

  Widget _buildFallbackGradient(String id) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getCoverGradient(id),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          _getCoverIcon(id),
          size: 80,
          color: Colors.white.withOpacity(0.85),
        ),
      ),
    );
  }

  List<Color> _getCoverGradient(String id) {
    if (id.contains('1')) {
      return const [Color(0xFF15803D), Color(0xFF4ADE80)];
    } else if (id.contains('2')) {
      return const [Color(0xFF1E1B4B), Color(0xFF4338CA)];
    } else {
      return const [Color(0xFF0369A1), Color(0xFF38BDF8)];
    }
  }

  IconData _getCoverIcon(String id) {
    if (id.contains('1')) {
      return Icons.pets_rounded;
    } else if (id.contains('2')) {
      return Icons.nightlight_round;
    } else {
      return Icons.wb_sunny_rounded;
    }
  }
}

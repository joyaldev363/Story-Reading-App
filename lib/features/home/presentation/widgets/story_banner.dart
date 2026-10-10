import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/story.dart';

class StoryBannerWidget extends StatefulWidget {
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
  State<StoryBannerWidget> createState() => _StoryBannerWidgetState();
}

class _StoryBannerWidgetState extends State<StoryBannerWidget> {
  late final PageController _pageController;
  Timer? _autoPlayTimer;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.activeIndex.toDouble();
    _pageController = PageController(
      initialPage: widget.activeIndex,
      viewportFraction: 0.92,
    );
    _pageController.addListener(_onScroll);
    _startAutoPlay();
  }

  void _onScroll() {
    if (_pageController.hasClients) {
      setState(() {
        _currentPage =
            _pageController.page ?? _pageController.initialPage.toDouble();
      });
    }
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    if (widget.banners.length <= 1) return;
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pageController.hasClients) {
        final nextPage =
            (_pageController.page!.round() + 1) % widget.banners.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          // Animated Carousel PageView
          SizedBox(
            height: 205,
            child: Listener(
              onPointerDown: (_) => _stopAutoPlay(),
              onPointerUp: (_) => _startAutoPlay(),
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.banners.length,
                onPageChanged: (index) {
                  widget.onPageChanged(index);
                },
                itemBuilder: (context, index) {
                  final story = widget.banners[index];

                  // Calculate smooth scale factor based on scroll position
                  final pageOffset = (_currentPage - index).abs();
                  final scale = (1.0 - (pageOffset * 0.08)).clamp(0.92, 1.0);
                  final opacity = (1.0 - (pageOffset * 0.3)).clamp(0.7, 1.0);

                  return Transform.scale(
                    scale: scale,
                    child: Opacity(
                      opacity: opacity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: _buildBannerCard(context, story, index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Expanding Pill Pagination Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.banners.length, (index) {
              final isCurrent =
                  index == (widget.activeIndex % widget.banners.length);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: isCurrent ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: isCurrent
                      ? AppColors.navyBlue
                      : AppColors.subtitleSlate.withOpacity(0.25),
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                            color: AppColors.navyBlue.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCard(BuildContext context, StoryEntity story, int index) {
    // Dynamic distinct gradient themes per index
    final gradients = [
      const [Color(0xFF0F2A4A), Color(0xFF1E3A8A)], // Deep Navy to Indigo
      const [Color(0xFF2E1065), Color(0xFF5B21B6)], // Deep Violet to Purple
      const [Color(0xFF064E3B), Color(0xFF047857)], // Emerald Green
    ];
    final cardGradient = gradients[index % gradients.length];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: LinearGradient(
          colors: cardGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: cardGradient.first.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Decorative Glow Circle & Illustration Icon
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  index % 2 == 0
                      ? Icons.pets_rounded
                      : Icons.auto_stories_rounded,
                  size: 64,
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
            ),
          ),

          // Glassmorphism Border Highlight Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1.5,
              ),
            ),
          ),

          // Content Overlay
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Star Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentGold,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentGold.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: AppColors.navyBlue,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        story.badgeTag ?? 'Story of the Day',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navyBlue,
                          letterSpacing: 0.2,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.52,
                      child: Text(
                        story.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.white.withOpacity(0.85),
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),

                // Read Story Action Button
                InkWell(
                  onTap: () => widget.onReadStoryTap?.call(story),
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 9.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentGold,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentGold.withOpacity(0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Read Story',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.navyBlue,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: AppColors.navyBlue,
                        ),
                      ],
                    ),
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

import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/story.dart';

class StoryDetailsPage extends StatefulWidget {
  final StoryEntity story;

  const StoryDetailsPage({
    super.key,
    required this.story,
  });

  @override
  State<StoryDetailsPage> createState() => _StoryDetailsPageState();
}

class _StoryDetailsPageState extends State<StoryDetailsPage> {
  late bool _isBookmarked;
  int _selectedLanguageMode = 0; // 0 = Both, 1 = English Only, 2 = Tamil Only
  double _fontSize = 15.5;
  bool _isPlayingAudio = false;
  final double _audioProgress = 0.25;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.story.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.story;

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation & Hero Banner Stack
            Stack(
              children: [
                // Top Gradient Cover Artwork
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _getCoverGradient(story.id),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
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
                  child: Center(
                    child: Icon(
                      _getCoverIcon(story.id),
                      size: 80,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ),

                // Navigation Bar Buttons Overlay
                Positioned(
                  top: 12,
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
                            _isBookmarked
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_outline_rounded,
                            color: _isBookmarked
                                ? const Color(0xFF635BFF)
                                : AppColors.navyBlue,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _isBookmarked = !_isBookmarked;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _isBookmarked
                                      ? 'Saved "${story.title}" to library'
                                      : 'Removed "${story.title}" from saved',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Scrollable Story Details & Text Reader
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Story Title & Badges
                    Text(
                      story.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.navyBlue,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 18, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${story.rating} (${story.reviewCount} reviews)',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navyBlue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.access_time_rounded,
                          size: 16,
                          color: Color(0xFF718096),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          story.readTime,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF718096),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Language Selector Segmented Buttons
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _buildLanguageSegment(0, 'English • தமிழ்'),
                          _buildLanguageSegment(1, 'English Only'),
                          _buildLanguageSegment(2, 'தமிழ் மட்டும்'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Audio Narration & Font Size Customization Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isPlayingAudio = !_isPlayingAudio;
                                  });
                                },
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF635BFF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _isPlayingAudio
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _isPlayingAudio
                                          ? 'Playing Audio Narration...'
                                          : 'Listen to Narration',
                                      style: const TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.navyBlue,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    LinearProgressIndicator(
                                      value: _audioProgress,
                                      backgroundColor: const Color(0xFFEEF2FF),
                                      color: const Color(0xFF635BFF),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Text Size Controls
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline_rounded,
                                      size: 20,
                                      color: Color(0xFF718096),
                                    ),
                                    onPressed: _fontSize > 13
                                        ? () => setState(() => _fontSize -= 1)
                                        : null,
                                  ),
                                  Text(
                                    '${_fontSize.toInt()}pt',
                                    style: const TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.navyBlue,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_circle_outline_rounded,
                                      size: 20,
                                      color: Color(0xFF718096),
                                    ),
                                    onPressed: _fontSize < 24
                                        ? () => setState(() => _fontSize += 1)
                                        : null,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Main Story Content Text
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_selectedLanguageMode == 0 || _selectedLanguageMode == 1) ...[
                            Text(
                              story.description,
                              style: TextStyle(
                                fontSize: _fontSize,
                                height: 1.65,
                                fontWeight: FontWeight.w500,
                                color: AppColors.navyBlue,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'Every morning, the loyal friend greeted everyone in the village with joy. Through acts of bravery and unwavering kindness, a lifelong bond of love was forged.',
                              style: TextStyle(
                                fontSize: _fontSize,
                                height: 1.65,
                                color: AppColors.navyBlue.withOpacity(0.9),
                              ),
                            ),
                          ],

                          if (_selectedLanguageMode == 0) ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14.0),
                              child: Divider(color: Color(0xFFE2E8F0)),
                            ),
                          ],

                          if (_selectedLanguageMode == 0 || _selectedLanguageMode == 2) ...[
                            Text(
                              'ஒரு காலத்தில், கிராமத்தில் வாழ்ந்த ஒரு உண்மையுள்ள நண்பன் அன்பும் கருணையும் கொண்ட ஒரு நல்ல பாடத்தை கற்பித்தான்.',
                              style: TextStyle(
                                fontSize: _fontSize,
                                height: 1.65,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'வாழ்க்கையில் உண்மையாகவும் அன்பாகவும் இருப்பது எப்போதும் உயர்ந்த பெருமையைத் தரும் என்பது இந்த கதையின் கருத்தாகும்.',
                              style: TextStyle(
                                fontSize: _fontSize,
                                height: 1.65,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Moral of the Story Highlight Card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFFDE68A), width: 1.2),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF59E0B),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.lightbulb_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Moral of the Story / கதையின் நீதி',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF92400E),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Loyalty and kindness always win the hearts of others.\nஉண்மையும் அன்பும் எப்போதுமே வெற்றி பெறும்.',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    height: 1.4,
                                    color: Color(0xFFB45309),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSegment(int index, String label) {
    final isSelected = _selectedLanguageMode == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedLanguageMode = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF635BFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF64748B),
            ),
          ),
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

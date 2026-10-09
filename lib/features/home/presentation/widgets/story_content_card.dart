import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/story.dart';

class StoryContentCardWidget extends StatelessWidget {
  final StoryEntity story;

  const StoryContentCardWidget({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // English Section Header
          _buildLanguageHeader('🇬🇧 English Version'),
          const SizedBox(height: 10),
          Text(
            story.description,
            style: const TextStyle(
              fontSize: 15.5,
              height: 1.65,
              fontWeight: FontWeight.w500,
              color: AppColors.navyBlue,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Every morning, the loyal friend greeted everyone in the village with joy. Through acts of bravery and unwavering kindness, a lifelong bond of love was forged.',
            style: TextStyle(
              fontSize: 15.5,
              height: 1.65,
              color: AppColors.navyBlue.withOpacity(0.9),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(color: Color(0xFFE2E8F0), height: 1),
          ),

          // Tamil Section Header
          _buildLanguageHeader('🇮🇳 தமிழ் வடிவம்'),
          const SizedBox(height: 10),
          const Text(
            'ஒரு காலத்தில், கிராமத்தில் வாழ்ந்த ஒரு உண்மையுள்ள நண்பன் அன்பும் கருணையும் கொண்ட ஒரு நல்ல பாடத்தை கற்பித்தான்.',
            style: TextStyle(
              fontSize: 15.5,
              height: 1.65,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'வாழ்க்கையில் உண்மையாகவும் அன்பாகவும் இருப்பது எப்போதும் உயர்ந்த பெருமையைத் தரும் என்பது இந்த கதையின் கருத்தாகும்.',
            style: TextStyle(
              fontSize: 15.5,
              height: 1.65,
              color: Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFF475569),
        ),
      ),
    );
  }
}

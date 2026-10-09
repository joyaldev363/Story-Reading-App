import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class StoryVocabularyCardWidget extends StatelessWidget {
  const StoryVocabularyCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFEEF2FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFF635BFF),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Vocabulary Builder / சொற்களஞ்சியம்',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navyBlue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildVocabRow('Loyalty', 'உண்மைத் தன்மை (விசுவாசம்)'),
          const SizedBox(height: 8),
          _buildVocabRow('Kindness', 'இரக்கம் (அன்பு)'),
          const SizedBox(height: 8),
          _buildVocabRow('Brave', 'தைரியமான (அஞ்சாமை)'),
        ],
      ),
    );
  }

  Widget _buildVocabRow(String word, String tamilMeaning) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Color(0xFF635BFF),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '$word = ',
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: AppColors.navyBlue,
          ),
        ),
        Expanded(
          child: Text(
            tamilMeaning,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF475569),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

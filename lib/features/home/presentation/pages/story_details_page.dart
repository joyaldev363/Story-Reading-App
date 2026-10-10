import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/story.dart';
import '../widgets/story_action_bar.dart';
import '../widgets/story_content_card.dart';
import '../widgets/story_details_header.dart';
import '../widgets/story_details_metadata.dart';
import '../widgets/story_moral_card.dart';
import '../widgets/story_vocabulary_card.dart';

class StoryDetailsPage extends StatefulWidget {
  final StoryEntity story;

  const StoryDetailsPage({super.key, required this.story});

  @override
  State<StoryDetailsPage> createState() => _StoryDetailsPageState();
}

class _StoryDetailsPageState extends State<StoryDetailsPage> {
  late bool _isBookmarked;

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
      body: Column(
        children: [
          // Top Hero Cover & Navigation Bar
          StoryDetailsHeaderWidget(
            story: story,
            isBookmarked: _isBookmarked,
            onBookmarkTap: () {
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

          // Scrollable Story Details & Text Reader
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title, Ratings & Category Badges Widget
                  StoryDetailsMetadataWidget(story: story),

                  const SizedBox(height: 20),

                  // Dual Language English & Tamil Content Card Widget
                  StoryContentCardWidget(story: story),

                  const SizedBox(height: 18),

                  // Key Vocabulary Builder Card Widget
                  const StoryVocabularyCardWidget(),

                  const SizedBox(height: 18),

                  // Golden Moral Banner Card Widget
                  const StoryMoralCardWidget(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Sticky Bottom Action Bar Widget
          StoryActionBarWidget(storyTitle: story.title),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../saved/data/datasources/saved_datasource.dart';
import '../../../saved/domain/entities/saved_story.dart';
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
  final SavedDataSource _savedDataSource = const SavedLocalDataSourceImpl();

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.story.isFavorite;
    _checkSavedStatus();
  }

  Future<void> _checkSavedStatus() async {
    final isSaved = await _savedDataSource.isStorySaved(widget.story.id);
    if (mounted) {
      setState(() {
        _isBookmarked = isSaved;
      });
    }
  }

  Future<void> _toggleBookmark() async {
    final story = widget.story;
    final savedStory = SavedStory(
      id: story.id,
      title: story.title,
      description: story.description,
      coverUrl: story.coverUrl,
      languageLabel: story.languageLabel,
      readTime: story.readTime,
      rating: story.rating,
      reviewCount: story.reviewCount,
      isSaved: true,
      status: SavedReadStatus.unread,
      savedAt: DateTime.now(),
    );

    final isNowSaved = await _savedDataSource.toggleSavedStory(savedStory);

    if (mounted) {
      setState(() {
        _isBookmarked = isNowSaved;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isNowSaved
                ? 'Saved "${story.title}" to library'
                : 'Removed "${story.title}" from saved',
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    }
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
            onBookmarkTap: _toggleBookmark,
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

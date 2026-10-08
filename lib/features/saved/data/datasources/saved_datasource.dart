import '../models/saved_story_model.dart';
import '../../domain/entities/saved_story.dart';

abstract class SavedDataSource {
  Future<List<SavedStoryModel>> getSavedStories();
  Future<List<SavedStoryModel>> searchSavedStories(String query);
  Future<void> removeSavedStory(String storyId);
  Future<void> toggleSavedStory(String storyId);
}

class SavedLocalDataSourceImpl implements SavedDataSource {
  final List<SavedStoryModel> _mockSavedStories = [
    SavedStoryModel(
      id: 'saved_1',
      title: 'The Loyal Dog',
      description: 'A heartwarming story about friendship, loyalty and kindness.',
      coverUrl: 'assets/images/stories/loyal_dog.png',
      languageLabel: 'English | தமிழ்',
      readTime: '5 min',
      rating: 4.8,
      reviewCount: 120,
      isSaved: true,
      status: SavedReadStatus.unread,
    ),
    SavedStoryModel(
      id: 'saved_2',
      title: 'The Boy and the Moon',
      description: 'A curious boy, a bright moon, and a magical adventure.',
      coverUrl: 'assets/images/stories/boy_moon.png',
      languageLabel: 'English | தமிழ்',
      readTime: '7 min',
      rating: 4.7,
      reviewCount: 98,
      isSaved: true,
      status: SavedReadStatus.reading,
    ),
    SavedStoryModel(
      id: 'saved_3',
      title: 'The Kind Little Girl',
      description: 'A sweet story about kindness, courage and helping others.',
      coverUrl: 'assets/images/stories/kind_girl.png',
      languageLabel: 'English | தமிழ்',
      readTime: '6 min',
      rating: 4.9,
      reviewCount: 156,
      isSaved: true,
      status: SavedReadStatus.unread,
    ),
    SavedStoryModel(
      id: 'saved_4',
      title: 'The Clever Fox',
      description: 'A smart fox, a tricky plan, and a big lesson.',
      coverUrl: 'assets/images/stories/clever_fox.png',
      languageLabel: 'English | தமிழ்',
      readTime: '5 min',
      rating: 4.6,
      reviewCount: 90,
      isSaved: true,
      status: SavedReadStatus.reading,
    ),
    SavedStoryModel(
      id: 'saved_5',
      title: 'The Magical Tree',
      description: 'An ancient tree that grants wishes to pure-hearted children.',
      coverUrl: 'assets/images/stories/magic_tree.png',
      languageLabel: 'English | தமிழ்',
      readTime: '8 min',
      rating: 4.9,
      reviewCount: 210,
      isSaved: true,
      status: SavedReadStatus.unread,
    ),
    SavedStoryModel(
      id: 'saved_6',
      title: 'The Brave Little Elephant',
      description: 'A little elephant discovers big courage in the deep jungle.',
      coverUrl: 'assets/images/stories/brave_elephant.png',
      languageLabel: 'English | தமிழ்',
      readTime: '4 min',
      rating: 4.7,
      reviewCount: 142,
      isSaved: true,
      status: SavedReadStatus.completed,
    ),
  ];

  @override
  Future<List<SavedStoryModel>> getSavedStories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_mockSavedStories.where((story) => story.isSaved));
  }

  @override
  Future<List<SavedStoryModel>> searchSavedStories(String query) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final lower = query.toLowerCase().trim();
    if (lower.isEmpty) {
      return getSavedStories();
    }
    return _mockSavedStories.where((story) {
      return story.isSaved &&
          (story.title.toLowerCase().contains(lower) ||
              story.description.toLowerCase().contains(lower));
    }).toList();
  }

  @override
  Future<void> removeSavedStory(String storyId) async {
    final index = _mockSavedStories.indexWhere((s) => s.id == storyId);
    if (index != -1) {
      final existing = _mockSavedStories[index];
      _mockSavedStories[index] = SavedStoryModel.fromEntity(
        existing.copyWith(isSaved: false),
      );
    }
  }

  @override
  Future<void> toggleSavedStory(String storyId) async {
    final index = _mockSavedStories.indexWhere((s) => s.id == storyId);
    if (index != -1) {
      final existing = _mockSavedStories[index];
      _mockSavedStories[index] = SavedStoryModel.fromEntity(
        existing.copyWith(isSaved: !existing.isSaved),
      );
    }
  }
}

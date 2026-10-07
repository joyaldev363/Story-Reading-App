import '../models/discover_story_model.dart';

abstract class DiscoverDataSource {
  Future<List<DiscoverStoryModel>> fetchPopularStories();
  Future<List<DiscoverStoryModel>> searchStories(String query);
}

class DiscoverLocalDataSourceImpl implements DiscoverDataSource {
  final List<DiscoverStoryModel> _stories = List.from(DiscoverStoryModel.mockPopularStories);

  @override
  Future<List<DiscoverStoryModel>> fetchPopularStories() async {
    // Simulate slight network/local delay
    await Future.delayed(const Duration(milliseconds: 200));
    return _stories;
  }

  @override
  Future<List<DiscoverStoryModel>> searchStories(String query) async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (query.trim().isEmpty) {
      return _stories;
    }
    final lowercaseQuery = query.toLowerCase();
    return _stories.where((story) {
      return story.title.toLowerCase().contains(lowercaseQuery) ||
          story.description.toLowerCase().contains(lowercaseQuery) ||
          story.languageLabel.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}

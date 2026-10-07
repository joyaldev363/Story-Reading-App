import '../entities/discover_story.dart';

abstract class DiscoverRepository {
  Future<List<DiscoverStory>> getPopularStories();
  Future<List<DiscoverStory>> searchStories(String query);
}

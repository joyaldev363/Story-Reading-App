import '../entities/saved_story.dart';

abstract class SavedRepository {
  Future<List<SavedStory>> getSavedStories();
  Future<List<SavedStory>> searchSavedStories(String query);
  Future<void> removeSavedStory(String storyId);
  Future<void> toggleSavedStory(String storyId);
}

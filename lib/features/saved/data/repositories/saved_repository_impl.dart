import '../../domain/entities/saved_story.dart';
import '../../domain/repositories/saved_repository.dart';
import '../datasources/saved_datasource.dart';

class SavedRepositoryImpl implements SavedRepository {
  final SavedDataSource dataSource;

  SavedRepositoryImpl({required this.dataSource});

  @override
  Future<List<SavedStory>> getSavedStories() async {
    return await dataSource.getSavedStories();
  }

  @override
  Future<List<SavedStory>> searchSavedStories(String query) async {
    return await dataSource.searchSavedStories(query);
  }

  @override
  Future<void> removeSavedStory(String storyId) async {
    await dataSource.removeSavedStory(storyId);
  }

  @override
  Future<void> toggleSavedStory(String storyId) async {
    await dataSource.toggleSavedStory(storyId);
  }
}

import '../entities/saved_story.dart';
import '../repositories/saved_repository.dart';

class SearchSavedStories {
  final SavedRepository repository;

  SearchSavedStories(this.repository);

  Future<List<SavedStory>> call(String query) async {
    return await repository.searchSavedStories(query);
  }
}

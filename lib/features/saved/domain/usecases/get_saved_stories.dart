import '../entities/saved_story.dart';
import '../repositories/saved_repository.dart';

class GetSavedStories {
  final SavedRepository repository;

  GetSavedStories(this.repository);

  Future<List<SavedStory>> call() async {
    return await repository.getSavedStories();
  }
}

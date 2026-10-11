import '../entities/saved_story.dart';
import '../repositories/saved_repository.dart';

class ToggleSavedStory {
  final SavedRepository repository;

  ToggleSavedStory(this.repository);

  Future<bool> call(SavedStory story) async {
    return await repository.toggleSavedStory(story);
  }
}

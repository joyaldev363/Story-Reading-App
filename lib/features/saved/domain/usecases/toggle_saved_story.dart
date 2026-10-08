import '../repositories/saved_repository.dart';

class ToggleSavedStory {
  final SavedRepository repository;

  ToggleSavedStory(this.repository);

  Future<void> call(String storyId) async {
    return await repository.toggleSavedStory(storyId);
  }
}

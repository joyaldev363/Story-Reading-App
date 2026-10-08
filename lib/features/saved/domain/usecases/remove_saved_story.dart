import '../repositories/saved_repository.dart';

class RemoveSavedStory {
  final SavedRepository repository;

  RemoveSavedStory(this.repository);

  Future<void> call(String storyId) async {
    return await repository.removeSavedStory(storyId);
  }
}

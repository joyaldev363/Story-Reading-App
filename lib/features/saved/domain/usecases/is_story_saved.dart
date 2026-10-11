import '../repositories/saved_repository.dart';

class IsStorySaved {
  final SavedRepository repository;

  IsStorySaved(this.repository);

  Future<bool> call(String storyId) async {
    return await repository.isStorySaved(storyId);
  }
}

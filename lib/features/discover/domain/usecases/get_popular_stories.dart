import '../entities/discover_story.dart';
import '../repositories/discover_repository.dart';

class GetPopularStories {
  final DiscoverRepository repository;

  GetPopularStories(this.repository);

  Future<List<DiscoverStory>> call() async {
    return await repository.getPopularStories();
  }
}

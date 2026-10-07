import '../entities/discover_story.dart';
import '../repositories/discover_repository.dart';

class SearchStories {
  final DiscoverRepository repository;

  SearchStories(this.repository);

  Future<List<DiscoverStory>> call(String query) async {
    return await repository.searchStories(query);
  }
}

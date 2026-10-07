import '../../domain/entities/discover_story.dart';
import '../../domain/repositories/discover_repository.dart';
import '../datasources/discover_datasource.dart';

class DiscoverRepositoryImpl implements DiscoverRepository {
  final DiscoverDataSource dataSource;

  DiscoverRepositoryImpl({required this.dataSource});

  @override
  Future<List<DiscoverStory>> getPopularStories() async {
    return await dataSource.fetchPopularStories();
  }

  @override
  Future<List<DiscoverStory>> searchStories(String query) async {
    return await dataSource.searchStories(query);
  }
}

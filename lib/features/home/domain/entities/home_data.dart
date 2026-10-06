import 'category.dart';
import 'story.dart';

class HomeDataEntity {
  final List<StoryEntity> featuredBanners;
  final List<CategoryEntity> categories;
  final List<StoryEntity> recommendedStories;

  const HomeDataEntity({
    required this.featuredBanners,
    required this.categories,
    required this.recommendedStories,
  });
}

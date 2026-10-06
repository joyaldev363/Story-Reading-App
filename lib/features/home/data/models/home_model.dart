import '../../domain/entities/category.dart';
import '../../domain/entities/home_data.dart';
import '../../domain/entities/story.dart';

class HomeModel extends HomeDataEntity {
  const HomeModel({
    required super.featuredBanners,
    required super.categories,
    required super.recommendedStories,
  });
}

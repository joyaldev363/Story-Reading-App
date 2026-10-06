import '../../domain/entities/home_data.dart';

class HomeModel extends HomeDataEntity {
  const HomeModel({
    required super.featuredBanners,
    required super.categories,
    required super.recommendedStories,
  });
}

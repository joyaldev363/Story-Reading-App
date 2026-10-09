import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/home_data.dart';
import '../../domain/entities/story.dart';
import '../../domain/usecases/get_home_data.dart';

class HomeController extends ChangeNotifier {
  final GetHomeData getHomeDataUseCase;

  HomeController({required this.getHomeDataUseCase});

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  HomeDataEntity? _homeData;
  HomeDataEntity? get homeData => _homeData;

  int _activeBannerIndex = 0;
  int get activeBannerIndex => _activeBannerIndex;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  String _selectedCategoryId = 'cat_all';
  String get selectedCategoryId => _selectedCategoryId;

  List<StoryEntity> get filteredRecommendedStories {
    if (_homeData == null) return [];
    var list = _homeData!.recommendedStories;

    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      list = list
          .where(
            (s) =>
                s.title.toLowerCase().contains(query) ||
                s.description.toLowerCase().contains(query),
          )
          .toList();
    }

    if (_selectedCategoryId != 'cat_all') {
      final category = _homeData!.categories.firstWhere(
        (c) => c.id == _selectedCategoryId,
        orElse: () => const CategoryEntity(
          id: '',
          title: '',
          icon: Icons.help,
          backgroundColor: Colors.white,
          iconColor: Colors.black,
        ),
      );
      final catTitle = category.title.toLowerCase();

      final filtered = list.where((story) {
        final title = story.title.toLowerCase();
        final desc = story.description.toLowerCase();
        if (catTitle == 'easy')
          return story.readTime.contains('5 min') || desc.contains('easy');
        if (catTitle == 'animals')
          return title.contains('dog') ||
              title.contains('fox') ||
              title.contains('lion');
        if (catTitle == 'fun' || catTitle == 'moral')
          return desc.contains('fun') ||
              desc.contains('moral') ||
              desc.contains('heartwarming') ||
              title.contains('fox');
        if (catTitle == 'fantasy')
          return title.contains('moon') ||
              desc.contains('adventure') ||
              desc.contains('magical');
        if (catTitle == 'classic')
          return title.contains('girl') ||
              desc.contains('kindness') ||
              desc.contains('lion');
        return title.contains(catTitle) || desc.contains(catTitle);
      }).toList();

      return filtered.isNotEmpty ? filtered : list;
    }

    return list;
  }

  void selectCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  Future<void> loadHomeData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _homeData = await getHomeDataUseCase();
    } catch (_) {
      // Handle error gracefully
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onBannerPageChanged(int index) {
    _activeBannerIndex = index;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleFavorite(String storyId) {
    if (_homeData == null) return;

    final updatedRecommended = _homeData!.recommendedStories.map((story) {
      if (story.id == storyId) {
        return story.copyWith(isFavorite: !story.isFavorite);
      }
      return story;
    }).toList();

    _homeData = HomeDataEntity(
      featuredBanners: _homeData!.featuredBanners,
      categories: _homeData!.categories,
      recommendedStories: updatedRecommended,
    );

    notifyListeners();
  }
}

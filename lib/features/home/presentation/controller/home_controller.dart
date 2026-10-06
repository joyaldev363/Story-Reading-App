import 'package:flutter/material.dart';
import '../../domain/entities/home_data.dart';
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

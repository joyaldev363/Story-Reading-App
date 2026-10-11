import 'package:flutter/material.dart';
import '../../../saved/data/datasources/saved_datasource.dart';
import '../../../saved/domain/entities/saved_story.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/home_data.dart';
import '../../domain/entities/story.dart';
import '../../domain/usecases/get_home_data.dart';

class HomeController extends ChangeNotifier {
  final GetHomeData getHomeDataUseCase;
  final SavedDataSource savedDataSource;

  HomeController({
    required this.getHomeDataUseCase,
    this.savedDataSource = const SavedLocalDataSourceImpl(),
  }) {
    SavedLocalDataSourceImpl.savedUpdateNotifier.addListener(_syncSavedStatus);
  }

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
        if (catTitle == 'easy') {
          return story.readTime.contains('5 min') || desc.contains('easy');
        }
        if (catTitle == 'animals') {
          return title.contains('dog') ||
              title.contains('fox') ||
              title.contains('lion');
        }
        if (catTitle == 'fun' || catTitle == 'moral') {
          return desc.contains('fun') ||
              desc.contains('moral') ||
              desc.contains('heartwarming') ||
              title.contains('fox');
        }
        if (catTitle == 'fantasy') {
          return title.contains('moon') ||
              desc.contains('adventure') ||
              desc.contains('magical');
        }
        if (catTitle == 'classic') {
          return title.contains('girl') ||
              desc.contains('kindness') ||
              desc.contains('lion');
        }
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
      final fetchedData = await getHomeDataUseCase();
      final updatedStories = <StoryEntity>[];

      for (final story in fetchedData.recommendedStories) {
        final isSaved = await savedDataSource.isStorySaved(story.id);
        updatedStories.add(story.copyWith(isFavorite: isSaved));
      }

      _homeData = HomeDataEntity(
        featuredBanners: fetchedData.featuredBanners,
        categories: fetchedData.categories,
        recommendedStories: updatedStories,
      );
    } catch (_) {
      // Handle error gracefully
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _syncSavedStatus() async {
    if (_homeData == null) return;

    final updatedStories = <StoryEntity>[];
    for (final story in _homeData!.recommendedStories) {
      final isSaved = await savedDataSource.isStorySaved(story.id);
      updatedStories.add(story.copyWith(isFavorite: isSaved));
    }

    _homeData = HomeDataEntity(
      featuredBanners: _homeData!.featuredBanners,
      categories: _homeData!.categories,
      recommendedStories: updatedStories,
    );
    notifyListeners();
  }

  void onBannerPageChanged(int index) {
    _activeBannerIndex = index;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> toggleFavorite(String storyId) async {
    if (_homeData == null) return;

    final index =
        _homeData!.recommendedStories.indexWhere((s) => s.id == storyId);
    if (index == -1) return;

    final targetStory = _homeData!.recommendedStories[index];
    final newFavoriteStatus = !targetStory.isFavorite;

    final updatedRecommended = List<StoryEntity>.from(
      _homeData!.recommendedStories,
    );
    updatedRecommended[index] =
        targetStory.copyWith(isFavorite: newFavoriteStatus);

    _homeData = HomeDataEntity(
      featuredBanners: _homeData!.featuredBanners,
      categories: _homeData!.categories,
      recommendedStories: updatedRecommended,
    );
    notifyListeners();

    final savedStory = SavedStory(
      id: targetStory.id,
      title: targetStory.title,
      description: targetStory.description,
      coverUrl: targetStory.coverUrl,
      languageLabel: targetStory.languageLabel,
      readTime: targetStory.readTime,
      rating: targetStory.rating,
      reviewCount: targetStory.reviewCount,
      isSaved: true,
      status: SavedReadStatus.unread,
      savedAt: DateTime.now(),
    );

    await savedDataSource.toggleSavedStory(savedStory);
  }

  @override
  void dispose() {
    SavedLocalDataSourceImpl.savedUpdateNotifier
        .removeListener(_syncSavedStatus);
    super.dispose();
  }
}

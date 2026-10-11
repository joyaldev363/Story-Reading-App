import 'package:flutter/material.dart';
import '../../../saved/data/datasources/saved_datasource.dart';
import '../../../saved/domain/entities/saved_story.dart';
import '../../domain/entities/discover_story.dart';
import '../../domain/usecases/get_popular_stories.dart';
import '../../domain/usecases/search_stories.dart';

class DiscoverController extends ChangeNotifier {
  final GetPopularStories getPopularStoriesUseCase;
  final SearchStories searchStoriesUseCase;
  final SavedDataSource savedDataSource;

  DiscoverController({
    required this.getPopularStoriesUseCase,
    required this.searchStoriesUseCase,
    this.savedDataSource = const SavedLocalDataSourceImpl(),
  }) {
    SavedLocalDataSourceImpl.savedUpdateNotifier.addListener(_syncSavedStatus);
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<DiscoverStory> _popularStories = [];
  List<DiscoverStory> get popularStories => _filteredStories;

  List<DiscoverStory> _filteredStories = [];

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  bool _hasNotification = true;
  bool get hasNotification => _hasNotification;

  Future<void> loadPopularStories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetched = await getPopularStoriesUseCase();
      final updated = <DiscoverStory>[];
      for (final story in fetched) {
        final isSaved = await savedDataSource.isStorySaved(story.id);
        updated.add(story.copyWith(isFavorite: isSaved));
      }
      _popularStories = updated;
      _filteredStories = List.from(_popularStories);
    } catch (_) {
      // Handle error state gracefully
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _syncSavedStatus() async {
    final updated = <DiscoverStory>[];
    for (final story in _popularStories) {
      final isSaved = await savedDataSource.isStorySaved(story.id);
      updated.add(story.copyWith(isFavorite: isSaved));
    }
    _popularStories = updated;

    if (_searchQuery.trim().isEmpty) {
      _filteredStories = List.from(_popularStories);
    } else {
      _filteredStories = _filteredStories.map((s) {
        final matching = _popularStories.firstWhere((p) => p.id == s.id, orElse: () => s);
        return s.copyWith(isFavorite: matching.isFavorite);
      }).toList();
    }
    notifyListeners();
  }

  Future<void> onSearchChanged(String query) async {
    _searchQuery = query;
    notifyListeners();

    if (query.trim().isEmpty) {
      _filteredStories = List.from(_popularStories);
    } else {
      final results = await searchStoriesUseCase(query);
      final updated = <DiscoverStory>[];
      for (final story in results) {
        final isSaved = await savedDataSource.isStorySaved(story.id);
        updated.add(story.copyWith(isFavorite: isSaved));
      }
      _filteredStories = updated;
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredStories = List.from(_popularStories);
    notifyListeners();
  }

  Future<void> toggleFavorite(String storyId) async {
    final index = _popularStories.indexWhere((s) => s.id == storyId);
    if (index == -1) return;

    final targetStory = _popularStories[index];
    final newFavoriteStatus = !targetStory.isFavorite;

    _popularStories[index] = targetStory.copyWith(isFavorite: newFavoriteStatus);

    final filteredIndex = _filteredStories.indexWhere((s) => s.id == storyId);
    if (filteredIndex != -1) {
      _filteredStories[filteredIndex] =
          _filteredStories[filteredIndex].copyWith(isFavorite: newFavoriteStatus);
    }

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

  void clearNotificationBadge() {
    _hasNotification = false;
    notifyListeners();
  }

  @override
  void dispose() {
    SavedLocalDataSourceImpl.savedUpdateNotifier.removeListener(_syncSavedStatus);
    super.dispose();
  }
}

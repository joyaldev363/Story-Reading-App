import 'package:flutter/material.dart';
import '../../domain/entities/discover_story.dart';
import '../../domain/usecases/get_popular_stories.dart';
import '../../domain/usecases/search_stories.dart';

class DiscoverController extends ChangeNotifier {
  final GetPopularStories getPopularStoriesUseCase;
  final SearchStories searchStoriesUseCase;

  DiscoverController({
    required this.getPopularStoriesUseCase,
    required this.searchStoriesUseCase,
  });

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
      _popularStories = await getPopularStoriesUseCase();
      _filteredStories = List.from(_popularStories);
    } catch (_) {
      // Handle error state gracefully
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> onSearchChanged(String query) async {
    _searchQuery = query;
    notifyListeners();

    if (query.trim().isEmpty) {
      _filteredStories = List.from(_popularStories);
    } else {
      _filteredStories = await searchStoriesUseCase(query);
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredStories = List.from(_popularStories);
    notifyListeners();
  }

  void toggleFavorite(String storyId) {
    _popularStories = _popularStories.map((story) {
      if (story.id == storyId) {
        return story.copyWith(isFavorite: !story.isFavorite);
      }
      return story;
    }).toList();

    _filteredStories = _filteredStories.map((story) {
      if (story.id == storyId) {
        return story.copyWith(isFavorite: !story.isFavorite);
      }
      return story;
    }).toList();

    notifyListeners();
  }

  void clearNotificationBadge() {
    _hasNotification = false;
    notifyListeners();
  }
}

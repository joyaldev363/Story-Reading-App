import 'package:flutter/material.dart';
import '../../domain/entities/saved_story.dart';
import '../../domain/usecases/get_saved_stories.dart';
import '../../domain/usecases/remove_saved_story.dart';
import '../../domain/usecases/search_saved_stories.dart';
import '../../domain/usecases/toggle_saved_story.dart';

class SavedController extends ChangeNotifier {
  final GetSavedStories getSavedStoriesUseCase;
  final SearchSavedStories searchSavedStoriesUseCase;
  final RemoveSavedStory removeSavedStoryUseCase;
  final ToggleSavedStory toggleSavedStoryUseCase;

  SavedController({
    required this.getSavedStoriesUseCase,
    required this.searchSavedStoriesUseCase,
    required this.removeSavedStoryUseCase,
    required this.toggleSavedStoryUseCase,
  });

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<SavedStory> _allStories = [];
  List<SavedStory> get allStories => _allStories;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  SavedReadStatus _selectedFilter = SavedReadStatus.all;
  SavedReadStatus get selectedFilter => _selectedFilter;

  int get allCount => _allStories.length;
  int get unreadCount => _allStories.where((s) => s.status == SavedReadStatus.unread).length;
  int get readingCount => _allStories.where((s) => s.status == SavedReadStatus.reading).length;

  List<SavedStory> get filteredStories {
    return _allStories.where((story) {
      // 1. Check status tab filter
      bool matchesTab = true;
      if (_selectedFilter == SavedReadStatus.unread) {
        matchesTab = story.status == SavedReadStatus.unread;
      } else if (_selectedFilter == SavedReadStatus.reading) {
        matchesTab = story.status == SavedReadStatus.reading;
      }

      // 2. Check search query filter
      bool matchesSearch = true;
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        matchesSearch = story.title.toLowerCase().contains(query) ||
            story.description.toLowerCase().contains(query);
      }

      return matchesTab && matchesSearch;
    }).toList();
  }

  Future<void> loadSavedStories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allStories = await getSavedStoriesUseCase();
    } catch (_) {
      // Handle error gracefully
      _allStories = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectFilter(SavedReadStatus status) {
    _selectedFilter = status;
    notifyListeners();
  }

  Future<void> toggleSaved(String storyId) async {
    final index = _allStories.indexWhere((s) => s.id == storyId);
    if (index != -1) {
      final story = _allStories[index];
      final newIsSaved = !story.isSaved;

      if (!newIsSaved) {
        _allStories.removeAt(index);
      } else {
        _allStories[index] = story.copyWith(isSaved: true);
      }
      notifyListeners();
      await toggleSavedStoryUseCase(storyId);
    }
  }

  Future<void> removeStory(String storyId) async {
    _allStories.removeWhere((s) => s.id == storyId);
    notifyListeners();
    await removeSavedStoryUseCase(storyId);
  }
}

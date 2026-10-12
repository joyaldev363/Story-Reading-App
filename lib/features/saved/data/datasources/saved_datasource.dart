import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/saved_story_model.dart';
import '../../domain/entities/saved_story.dart';

abstract class SavedDataSource {
  Future<List<SavedStoryModel>> getSavedStories();
  Future<List<SavedStoryModel>> searchSavedStories(String query);
  Future<void> removeSavedStory(String storyId);
  Future<bool> toggleSavedStory(SavedStory story);
  Future<bool> isStorySaved(String storyId);
}

class SavedLocalDataSourceImpl implements SavedDataSource {
  static const String _keySavedStories = 'saved_stories_cache';
  static final ValueNotifier<int> savedUpdateNotifier = ValueNotifier<int>(0);

  const SavedLocalDataSourceImpl();

  @override
  Future<List<SavedStoryModel>> getSavedStories() async {
    final prefs = await SharedPreferences.getInstance();
    final rawJson = prefs.getString(_keySavedStories);
    if (rawJson == null || rawJson.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded
          .map((item) => SavedStoryModel.fromJson(item as Map<String, dynamic>))
          .where((story) => story.isSaved)
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<List<SavedStoryModel>> searchSavedStories(String query) async {
    final allStories = await getSavedStories();
    final lower = query.toLowerCase().trim();
    if (lower.isEmpty) {
      return allStories;
    }
    return allStories.where((story) {
      return story.title.toLowerCase().contains(lower) ||
          story.description.toLowerCase().contains(lower);
    }).toList();
  }

  @override
  Future<void> removeSavedStory(String storyId) async {
    final prefs = await SharedPreferences.getInstance();
    final stories = await getSavedStories();
    final updated = stories.where((s) => s.id != storyId).toList();

    final encoded = jsonEncode(updated.map((s) => s.toJson()).toList());
    await prefs.setString(_keySavedStories, encoded);
    savedUpdateNotifier.value++;
  }

  @override
  Future<bool> toggleSavedStory(SavedStory story) async {
    final prefs = await SharedPreferences.getInstance();
    final stories = await getSavedStories();
    final index = stories.indexWhere((s) => s.id == story.id);

    bool isNowSaved;
    if (index != -1) {
      // Story exists, remove it
      stories.removeAt(index);
      isNowSaved = false;
    } else {
      // Story doesn't exist, add it
      stories.insert(
        0,
        SavedStoryModel(
          id: story.id,
          title: story.title,
          description: story.description,
          coverUrl: story.coverUrl,
          languageLabel: story.languageLabel,
          readTime: story.readTime,
          rating: story.rating,
          reviewCount: story.reviewCount,
          isSaved: true,
          status: story.status,
          savedAt: DateTime.now(),
        ),
      );
      isNowSaved = true;
    }

    final encoded = jsonEncode(stories.map((s) => s.toJson()).toList());
    await prefs.setString(_keySavedStories, encoded);
    savedUpdateNotifier.value++;
    return isNowSaved;
  }

  @override
  Future<bool> isStorySaved(String storyId) async {
    final stories = await getSavedStories();
    return stories.any((s) => s.id == storyId && s.isSaved);
  }
}

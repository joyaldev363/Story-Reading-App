import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/story.dart';
import '../models/home_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeModel> fetchHomeData();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl();

  @override
  Future<HomeModel> fetchHomeData() async {
    // Return rich mock data strictly matching the requested UI design mock
    final featuredBanners = [
      const StoryEntity(
        id: '1',
        title: 'The Clever Fox',
        description: 'A smart fox, a tricky plan, and a big lesson.',
        coverUrl: 'assets/images/stories/clever_fox.png',
        languageLabel: 'English | தமிழ்',
        readTime: '5 min read',
        badgeTag: 'Story of the Day',
      ),
      const StoryEntity(
        id: '2',
        title: 'The Brave Lion',
        description: 'An inspiring tale of courage and leadership in the wild.',
        coverUrl: 'assets/images/stories/brave_lion.png',
        languageLabel: 'English | தமிழ்',
        readTime: '6 min read',
        badgeTag: 'Trending Story',
      ),
      const StoryEntity(
        id: '3',
        title: 'The Magic Treehouse',
        description:
            'Secrets in the deep forest and a magical voyage across time.',
        coverUrl: 'assets/images/stories/magic_treehouse.png',
        languageLabel: 'English | தமிழ்',
        readTime: '8 min read',
        badgeTag: 'Popular Choice',
      ),
      const StoryEntity(
        id: '4',
        title: 'The Stars in the Jar',
        description:
            'Catching fallen stars and lighting up the night sky with wonder.',
        coverUrl: 'assets/images/stories/stars_jar.png',
        languageLabel: 'English | தமிழ்',
        readTime: '6 min read',
        badgeTag: 'Bedtime Special',
      ),
    ];

    final categories = [
      const CategoryEntity(
        id: 'cat_all',
        title: 'All',
        icon: Icons.grid_view_rounded,
        backgroundColor: Color(0xFFE8EAF6),
        iconColor: Color(0xFF0F2A4A),
      ),
      const CategoryEntity(
        id: 'cat_1',
        title: 'Easy',
        icon: Icons.eco_rounded,
        backgroundColor: Color(0xFFE8F5E9),
        iconColor: Color(0xFF4CAF50),
      ),
      const CategoryEntity(
        id: 'cat_2',
        title: 'Fun',
        icon: Icons.sentiment_very_satisfied_rounded,
        backgroundColor: Color(0xFFFFF8E1),
        iconColor: Color(0xFFFFB300),
      ),
      const CategoryEntity(
        id: 'cat_3',
        title: 'Moral',
        icon: Icons.favorite_rounded,
        backgroundColor: Color(0xFFFCE4EC),
        iconColor: Color(0xFFE91E63),
      ),
      const CategoryEntity(
        id: 'cat_4',
        title: 'Animals',
        icon: Icons.pets_rounded,
        backgroundColor: Color(0xFFFFF3E0),
        iconColor: Color(0xFFFB8C00),
      ),
      const CategoryEntity(
        id: 'cat_5',
        title: 'Fantasy',
        icon: Icons.auto_awesome_rounded,
        backgroundColor: Color(0xFFF3E5F5),
        iconColor: Color(0xFFAB47BC),
      ),
      const CategoryEntity(
        id: 'cat_6',
        title: 'Classic',
        icon: Icons.menu_book_rounded,
        backgroundColor: Color(0xFFE3F2FD),
        iconColor: Color(0xFF1976D2),
      ),
    ];

    final recommendedStories = [
      const StoryEntity(
        id: 'rec_1',
        title: 'The Loyal Dog',
        description:
            'A heartwarming story about friendship, loyalty and kindness.',
        coverUrl: 'assets/images/stories/loyal_dog.png',
        languageLabel: 'English | தமிழ்',
        readTime: '5 min',
        rating: 4.8,
        reviewCount: 120,
        isFavorite: false,
      ),
      const StoryEntity(
        id: 'rec_2',
        title: 'The Boy and the Moon',
        description: 'A curious boy, a bright moon, and a magical adventure.',
        coverUrl: 'assets/images/stories/boy_moon.png',
        languageLabel: 'English | தமிழ்',
        readTime: '7 min',
        rating: 4.7,
        reviewCount: 98,
        isFavorite: false,
      ),
      const StoryEntity(
        id: 'rec_3',
        title: 'The Kind Little Girl',
        description:
            'A sweet story about kindness, courage and helping others.',
        coverUrl: 'assets/images/stories/kind_girl.png',
        languageLabel: 'English | தமிழ்',
        readTime: '6 min',
        rating: 4.9,
        reviewCount: 156,
        isFavorite: false,
      ),
    ];

    return HomeModel(
      featuredBanners: featuredBanners,
      categories: categories,
      recommendedStories: recommendedStories,
    );
  }
}

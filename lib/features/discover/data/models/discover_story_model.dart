import '../../domain/entities/discover_story.dart';

class DiscoverStoryModel extends DiscoverStory {
  const DiscoverStoryModel({
    required super.id,
    required super.title,
    required super.description,
    required super.coverUrl,
    required super.languageLabel,
    required super.readTime,
    super.rating,
    super.reviewCount,
    super.isFavorite,
  });

  factory DiscoverStoryModel.fromJson(Map<String, dynamic> json) {
    return DiscoverStoryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      coverUrl: json['coverUrl'] as String,
      languageLabel: json['languageLabel'] as String? ?? 'English | தமிழ்',
      readTime: json['readTime'] as String? ?? '5 min',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'coverUrl': coverUrl,
      'languageLabel': languageLabel,
      'readTime': readTime,
      'rating': rating,
      'reviewCount': reviewCount,
      'isFavorite': isFavorite,
    };
  }

  factory DiscoverStoryModel.fromEntity(DiscoverStory entity) {
    return DiscoverStoryModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      coverUrl: entity.coverUrl,
      languageLabel: entity.languageLabel,
      readTime: entity.readTime,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      isFavorite: entity.isFavorite,
    );
  }

  static List<DiscoverStoryModel> get mockPopularStories => const [
        DiscoverStoryModel(
          id: 'story_1',
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
        DiscoverStoryModel(
          id: 'story_2',
          title: 'The Boy and the Moon',
          description:
              'A curious boy, a bright moon, and a magical adventure.',
          coverUrl: 'assets/images/stories/boy_and_moon.png',
          languageLabel: 'English | தமிழ்',
          readTime: '7 min',
          rating: 4.7,
          reviewCount: 98,
          isFavorite: false,
        ),
        DiscoverStoryModel(
          id: 'story_3',
          title: 'The Kind Little Girl',
          description:
              'A sweet story about kindness, courage and helping others.',
          coverUrl: 'assets/images/stories/kind_little_girl.png',
          languageLabel: 'English | தமிழ்',
          readTime: '6 min',
          rating: 4.9,
          reviewCount: 156,
          isFavorite: false,
        ),
        DiscoverStoryModel(
          id: 'story_4',
          title: 'The Clever Fox',
          description:
              'A smart fox, a tricky plan, and a big lesson.',
          coverUrl: 'assets/images/stories/clever_fox.png',
          languageLabel: 'English | தமிழ்',
          readTime: '5 min',
          rating: 4.6,
          reviewCount: 90,
          isFavorite: false,
        ),
      ];
}

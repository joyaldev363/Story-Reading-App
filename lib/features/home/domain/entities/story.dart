class StoryEntity {
  final String id;
  final String title;
  final String description;
  final String coverUrl;
  final String languageLabel; // e.g. 'English | தமிழ்'
  final String readTime; // e.g. '5 min read' or '5 min'
  final double rating;
  final int reviewCount;
  final bool isFavorite;
  final String? badgeTag; // e.g. 'Story of the Day'

  const StoryEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.languageLabel,
    required this.readTime,
    this.rating = 5.0,
    this.reviewCount = 0,
    this.isFavorite = false,
    this.badgeTag,
  });

  StoryEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? coverUrl,
    String? languageLabel,
    String? readTime,
    double? rating,
    int? reviewCount,
    bool? isFavorite,
    String? badgeTag,
  }) {
    return StoryEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      languageLabel: languageLabel ?? this.languageLabel,
      readTime: readTime ?? this.readTime,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isFavorite: isFavorite ?? this.isFavorite,
      badgeTag: badgeTag ?? this.badgeTag,
    );
  }
}

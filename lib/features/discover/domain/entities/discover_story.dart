class DiscoverStory {
  final String id;
  final String title;
  final String description;
  final String coverUrl;
  final String languageLabel; // e.g., 'English | தமிழ்'
  final String readTime; // e.g., '5 min'
  final double rating;
  final int reviewCount;
  final bool isFavorite;

  const DiscoverStory({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.languageLabel,
    required this.readTime,
    this.rating = 5.0,
    this.reviewCount = 0,
    this.isFavorite = false,
  });

  DiscoverStory copyWith({
    String? id,
    String? title,
    String? description,
    String? coverUrl,
    String? languageLabel,
    String? readTime,
    double? rating,
    int? reviewCount,
    bool? isFavorite,
  }) {
    return DiscoverStory(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      languageLabel: languageLabel ?? this.languageLabel,
      readTime: readTime ?? this.readTime,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

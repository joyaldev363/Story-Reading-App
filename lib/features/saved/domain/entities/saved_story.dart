enum SavedReadStatus { all, unread, reading, completed }

class SavedStory {
  final String id;
  final String title;
  final String description;
  final String coverUrl;
  final String languageLabel;
  final String readTime;
  final double rating;
  final int reviewCount;
  final bool isSaved;
  final SavedReadStatus status;
  final DateTime? savedAt;

  const SavedStory({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.languageLabel,
    required this.readTime,
    required this.rating,
    required this.reviewCount,
    this.isSaved = true,
    this.status = SavedReadStatus.unread,
    this.savedAt,
  });

  SavedStory copyWith({
    String? id,
    String? title,
    String? description,
    String? coverUrl,
    String? languageLabel,
    String? readTime,
    double? rating,
    int? reviewCount,
    bool? isSaved,
    SavedReadStatus? status,
    DateTime? savedAt,
  }) {
    return SavedStory(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      languageLabel: languageLabel ?? this.languageLabel,
      readTime: readTime ?? this.readTime,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isSaved: isSaved ?? this.isSaved,
      status: status ?? this.status,
      savedAt: savedAt ?? this.savedAt,
    );
  }
}
